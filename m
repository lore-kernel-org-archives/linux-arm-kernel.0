From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 11 Jun 2017 12:15:38 +0100
Subject: [PATCH 1/2] dt-bindings: mfd: update STM32 timers clock names
In-Reply-To: <CA+M3ks7sQ_1kF_ZgQ1+mLwDVo2=CVmACFBvSuY+FyZ9WXY=5tw@mail.gmail.com>
References: <1496993874-9870-1-git-send-email-fabrice.gasnier@st.com>
 <1496993874-9870-2-git-send-email-fabrice.gasnier@st.com>
 <CA+M3ks7sQ_1kF_ZgQ1+mLwDVo2=CVmACFBvSuY+FyZ9WXY=5tw@mail.gmail.com>
Message-ID: <20170611121538.0e7e757d@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 9 Jun 2017 09:43:21 +0200
Benjamin Gaignard <benjamin.gaignard@linaro.org> wrote:

> 2017-06-09 9:37 GMT+02:00 Fabrice Gasnier <fabrice.gasnier@st.com>:
> > Clock name has been updated during driver/DT binding review:
> > https://lkml.org/lkml/2016/12/13/718
> > Update DT binding doc to reflect this.
> >
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Should have a fixes tag as we should probably be pushing this
to stable...  Rob / Mark - up to you guys on both of these for
the path they take (assuming Lee is happy with patch!)

Fixes: d0f949e220fd ("mfd: Add STM32 Timers driver")
I think...
> > ---
> >  Documentation/devicetree/bindings/mfd/stm32-timers.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/stm32-timers.txt b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
> > index bbd083f..1db6e00 100644
> > --- a/Documentation/devicetree/bindings/mfd/stm32-timers.txt
> > +++ b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
> > @@ -31,7 +31,7 @@ Example:
> >                 compatible = "st,stm32-timers";
> >                 reg = <0x40010000 0x400>;
> >                 clocks = <&rcc 0 160>;
> > -               clock-names = "clk_int";
> > +               clock-names = "int";
> >
> >                 pwm {
> >                         compatible = "st,stm32-pwm";
> > --
> > 1.9.1
> >  
> 
> Acked-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
