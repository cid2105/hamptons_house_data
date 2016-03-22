from spyre import server
import plotly.plotly as py
import plotly.tools as tls
import pandas as pd
import urllib2
import json
py.sign_in('cid2105', '7qzehgrmd9')

class StockExample(server.App):

    panel = pd.read_pickle("panel.pkl")

    title = "Historical Stock Prices"

    inputs = [{     "type":'dropdown',
                    "label": 'Metric', 
                    "options" : [ {"label":key, "value": key} for key in panel.keys() ],
                    "key": 'metric', 
                    "action_id": "update_data"}]

    controls = [{   "type" : "hidden",
                    "id" : "update_data"}]

    tabs = ["Plot", "Table"]

    outputs = [{ "type" : "plot",
                    "id" : "plot",
                    "control_id" : "update_data",
                    "tab" : "Plot"},
                { "type" : "table",
                    "id" : "table_id",
                    "control_id" : "update_data",
                    "tab" : "Table",
                    "on_page_load" : True }]

    def getData(self, params):
        self.metric = params['metric']
        df = self.panel[self.metric]
        df = df.dropna(axis=0, how="all")
        df.insert(0, "Date", df.index)
        return df

    def getPlot(self, params):
        df = self.getData(params)
        plt_obj = df.plot(figsize=(15,10))
        plt_obj.set_ylabel("Price")
        plt_obj.set_title(self.metric)
        fig = plt_obj.get_figure()
        return fig

app = StockExample()
app.launch(port=9093)