From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 31 Oct 2013 15:35:55 +0800
Subject: [PATCH 3/3] ARM: dts: i.MX53: Devicetree for Voipac Baseboard
 using x53-dmm-668 module
In-Reply-To: <1382662545.8819.0.camel@linux-builds1>
References: <1382651769-21238-1-git-send-email-lisovy@gmail.com>
 <1382651769-21238-4-git-send-email-lisovy@gmail.com>
 <1382662545.8819.0.camel@linux-builds1>
Message-ID: <20131031073553.GG23549@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 07:55:45PM -0500, Dinh Nguyen wrote:
> On Thu, 2013-10-24 at 23:56 +0200, Rostislav Lisovy wrote:
> > Supported peripherals: Audio -- headphone output, LEDs, Buttons
> > (using keyboard controller), SD-card.
> > 
> > Signed-off-by: Rostislav Lisovy <lisovy@gmail.com>
> > 
> >  create mode 100644 arch/arm/boot/dts/imx53-voipac-bsb.dts
> > 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 802720e..5571af6 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -133,6 +133,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
> >  	imx53-mba53.dtb \
> >  	imx53-qsb.dtb \
> >  	imx53-smd.dtb \
> > +	imx53-voipac-bsb.dts \
> 
> I think this should be imx32-voipac-bsb.dtb.

I just fixed it up and applied the series.

Shawn
