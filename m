From: weiqing.kong@mediatek.com (Weiqing Kong)
Date: Fri, 23 Jun 2017 10:10:39 +0800
Subject: [PATCH v2 3/4] arm: dts: mt2701: Add display bls related nodes
 for MT2701
In-Reply-To: <1498123650.25128.1.camel@mtksdaap41>
References: <1498121019-21984-1-git-send-email-erin.lo@mediatek.com>
 <1498121019-21984-4-git-send-email-erin.lo@mediatek.com>
 <1498123650.25128.1.camel@mtksdaap41>
Message-ID: <1498183839.29101.2.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-06-22 at 17:27 +0800, Yingjoe Chen wrote:
> On Thu, 2017-06-22 at 16:43 +0800, Erin Lo wrote:
> > From: Weiqing Kong <weiqing.kong@mediatek.com>
> > 
> > This patch adds board related config for backlight
> > 
> > Signed-off-by: Weiqing Kong <weiqing.kong@mediatek.com>
> > Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> > ---
> >  arch/arm/boot/dts/mt2701-evb.dts | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/mt2701-evb.dts b/arch/arm/boot/dts/mt2701-evb.dts
> > index a483798..e49c2b7 100644
> > --- a/arch/arm/boot/dts/mt2701-evb.dts
> > +++ b/arch/arm/boot/dts/mt2701-evb.dts
> 
> <...>
> 
> > +
> > +&bls {
> > +	status = "okay";
> > +};
> > +
> > +&mmsys {
> > +	status = "okay";
> > +};
> > +
> > +&pio {
> > +	pwm_bls_gpio: pwm_bls_gpio {
> > +		pins_cmd_dat {
> > +			pinmux = <MT2701_PIN_208_AUD_EXT_CK1__FUNC_DISP_PWM>;
> > +		};
> > +	};
> >  };
> >  
> >  &auxadc {
> 
> 
> To help merge, I think this should be sorted according to name.
> 
> Joe.C

Thanks for your advice, I will refine this patch as quickly.

Weiqing Kong
> 
> 
> 
> 
