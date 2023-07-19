//+------------------------------------------------------------------+
//|                                    Custom indicator template.mq4 |
//|                        Copyright 2023, MetaQuotes Software Corp. |
//|                                        https://github.com/sdstar |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Software Corp."
#property link      "https://github.com/sdstar"
#property version   "1.00"
#property strict




//+------------------------------------------------------------------+
//| 1. Indicator Is Drawn In The Main Window Or Separate Window      |
//+------------------------------------------------------------------+
//--- indicator window
#property indicator_chart_window
//#property indicator_separate_window




//+------------------------------------------------------------------+
//| 2. Buffers And Arrays                                            |
//+------------------------------------------------------------------+
//--- 2.1. Number of buffers
#property indicator_buffers 2


//--- 2.2. Figures of buffers
#property indicator_color1 Green
#property indicator_color2 Red


//--- 2.3. Declaring arrays (for indicator buffers)
//--- main arrays (Buffers) 
   double bufferA[];
   double bufferB[];
   
   
//--- calculative arrays
   double arrayA[];   
   double arrayB[];




//+------------------------------------------------------------------+
//| 3. Included Files                                                |
//+------------------------------------------------------------------+
//#include <barlib.mqh>




//+------------------------------------------------------------------+
//| 4. Inputs                                                        |
//+------------------------------------------------------------------+
input ENUM_TIMEFRAMES InpTimeframe  = PERIOD_CURRENT; // Timeframe
input int             InpPeriod     = 30;             // Period




//+------------------------------------------------------------------+
//| 5. Custom Indicator Initialization Event Listener                |
//+------------------------------------------------------------------+
int OnInit(){

//--- 5.1. Indicator buffers mapping
   IndicatorBuffers(4);
   
//--- 5.2. Assigning an array to a buffer
   SetIndexBuffer(0,bufferA);
   SetIndexBuffer(1,bufferB);
   SetIndexBuffer(2,arrayA);
   SetIndexBuffer(3,arrayB);

//--- 5.3. Define drawing styles   
   SetIndexStyle(0,DRAW_LINE,STYLE_SOLID,2,clrGreen);
   SetIndexStyle(1,DRAW_LINE,STYLE_DOT,1,clrRed);
   SetIndexStyle(2,DRAW_NONE);
   SetIndexStyle(3,DRAW_NONE);

//--- 5.4. Define buffers label   
   SetIndexLabel(0,"Buffer A");
   SetIndexLabel(0,"Buffer B");
   


   return(INIT_SUCCEEDED);
  }




//+------------------------------------------------------------------+
//| 6. Custom Indicator Deinitialization Event Listener              |
//+------------------------------------------------------------------+
void OnDeinit(const int reason){

   //ObjectsDeleteAll(0, InpPrefix, 0, OBJ_HLINE);
   //ChartRedraw(0);   
   
}  


  
  
//+------------------------------------------------------------------+
//| 7. Custom Indicator Iteration Event Listener                     |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[]){
                
//--- 7.1. Loop through bars and set value of each buffer on i bar   
   //--- iteration method with specific period
      if(rates_total <= InpPeriod) return 0;
      int count = (prev_calculated==0) ? (rates_total - InpPeriod-1) : (rates_total - prev_calculated +1);

      for(int i=count-1; i>=0; i--){
         Print(Close[i]);
      }


   //--- iteration method without specific period
     int UnchangedBars = IndicatorCounted();
     int ChangedBars = Bars - UnchangedBars;  // Bars = UnchangedBars + ChangedBars

     for(int bar = ChangedBars-1; bar >= 0; bar--) {
       // update (i.e. recalculate) only the changed bars
        Print(Open[bar]);
     } 
   
   
   //--- 8. Use custom functions
   //DoSomething();
   
   
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+




//+------------------------------------------------------------------+
//| Indicator Creating Guide                                         |
//+------------------------------------------------------------------+
/*


1. Indicator is drawn in the main window or separate window (#property)

2. Buffers and arrays

   2.1. Number of buffers                                   (#property)

   2.2. Figures of buffers                                  (#property)

   2.3. Declaring arrays (for indicator buffers)

3. Included files                                           (#include)

4. Inputs                                                   (input)

5. Custom indicator initialization event listener           (OnInit())

   5.1. Indicator buffers mapping                           (IndicatorBuffers())

   5.2. Assigning an array to a buffer                      (SetIndexBuffer())
   
   5.3. Define drawing styles                               (SetIndexStyle())
   
   5.4. Define buffers label                                (SetIndexLabel())
   
6. Custom indicator deinitialization event listener         (OnDeinit())

7. Custom indicator iteration event listener                (OnCalculate())

   7.1. Loop through bars and set value of each buffer on i bar
   
8. Use custom functions

*/
