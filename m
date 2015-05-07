From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 7 May 2015 20:21:39 +0100
Subject: [STLinux Kernel] [PATCH 08/12] rtc: bindings: Supply knowledge
 of a third supported device - clocksource
In-Reply-To: <20150507141245.GA9793@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-9-git-send-email-lee.jones@linaro.org>
 <20150507141245.GA9793@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <20150507192139.GE16220@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/rtc/rtc-st-lpc.txt | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/rtc-st-lpc.txt b/Documentation/devicetree/bindings/rtc/rtc-st-lpc.txt
> > index 73407f50..daf8826 100644
> > --- a/Documentation/devicetree/bindings/rtc/rtc-st-lpc.txt
> > +++ b/Documentation/devicetree/bindings/rtc/rtc-st-lpc.txt
> > @@ -1,20 +1,23 @@
> >  STMicroelectronics Low Power Controller (LPC) - RTC
> >  ===================================================
> >  
> > -LPC currently supports Watchdog OR Real Time Clock functionality.
> > +LPC currently supports Watchdog OR Real Time Clock OR Clocksource
> > +functionality.
> >  
> >  [See: ../watchdog/st_lpc_wdt.txt for Watchdog options]
> > +[See: ../timer/st,stih407-lpc for Clocksource options]
> >  
> >  Required properties
> >  
> > -- compatible 	: Must be one of: "st,stih407-lpc" "st,stih416-lpc"
> > -				  "st,stih415-lpc" "st,stid127-lpc"
> > +- compatible 	: Must be: "st,stih407-lpc"
> 
> You are removing the compatibles documentation for the other supported SoC's like
> stih416-lpc stih415-lpc here.

It would be pretty difficult to do that by mistake. :)

See the comment I made to the Watchdog bindings patch for more info.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
