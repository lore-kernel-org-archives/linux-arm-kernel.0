From: manu@bidouilliste.com (Emmanuel Vadot)
Date: Thu, 5 Jan 2017 18:37:34 +0100
Subject: [PATCH] ARM: dts: sunxi: Enable spi1 and spi2 for Olimex A20
 SOM EVB
In-Reply-To: <20170105171601.us4wffupptilvvqp@lukather>
References: <20161226175349.17712-1-manu@bidouilliste.com>
 <20170105171601.us4wffupptilvvqp@lukather>
Message-ID: <20170105183734.c56cf3e0be4ad4ac21028851@bidouilliste.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


 Hi,

On Thu, 5 Jan 2017 18:16:01 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> Hi,
> 
> On Mon, Dec 26, 2016 at 06:53:49PM +0100, Emmanuel Vadot wrote:
> > Enable the spi1 and spi2 node since the pins are exposed on the UEXT
> > connectors.
> > 
> > Signed-off-by: Emmanuel Vadot <manu@bidouilliste.com>
> > ---
> >  arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
> > index 669a1c338c76..fa8c6f60552b 100644
> > --- a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
> > +++ b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
> > @@ -300,12 +300,14 @@
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&spi1_pins_a>,
> >  		    <&spi1_cs0_pins_a>;
> > +	status = "okay";
> >  };
> >  
> >  &spi2 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&spi2_pins_a>,
> >  		    <&spi2_cs0_pins_a>;
> > +	status = "okay";
> >  };
> 
> Those nodes don't exist unfortunately. Maybe you forgot to send one
> patch?
> 
> Thanks!
> Maxime
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

 It's based on a previous sent patch :
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-November/469288.html

 You said you'll squash the two commits.

-- 
Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
