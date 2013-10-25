From: lisovy@gmail.com (Rostislav Lisovy)
Date: Fri, 25 Oct 2013 08:25:13 +0200
Subject: [PATCH 3/3] ARM: dts: i.MX53: Devicetree for Voipac Baseboard
 using x53-dmm-668 module
In-Reply-To: <1382662545.8819.0.camel@linux-builds1>
References: <1382651769-21238-1-git-send-email-lisovy@gmail.com>
 <1382651769-21238-4-git-send-email-lisovy@gmail.com>
 <1382662545.8819.0.camel@linux-builds1>
Message-ID: <1382682313.22223.3.camel@lolumad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for my mistake. I will fix that, but if somebody can review the
rest of the patches (so I won't be resending the whole patchset after
each simple fix).

Rostislav Lisovy


On Thu, 2013-10-24 at 19:55 -0500, Dinh Nguyen wrote:
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
> >       imx53-mba53.dtb \
> >       imx53-qsb.dtb \
> >       imx53-smd.dtb \
> > +     imx53-voipac-bsb.dts \
> 
> I think this should be imx32-voipac-bsb.dtb.
> 
> Dinh
> >       imx6dl-sabreauto.dtb \
> >       imx6dl-sabresd.dtb \
> >       imx6dl-wandboard.dtb \
