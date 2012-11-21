From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Nov 2012 21:18:00 +0900
Subject: [PATCH 0/4] ARM: dts: exynos4210-origen: Device tree fixes
In-Reply-To: <1803002.oscJKykDTC@amdc1227>
References: <1353336396-21161-1-git-send-email-t.figa@samsung.com>
 <1803002.oscJKykDTC@amdc1227>
Message-ID: <0e7c01cdc7e2$3fc71380$bf553a80$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> Hi Kgene,
> 
> On Monday 19 of November 2012 15:46:32 Tomasz Figa wrote:
> > This patch series fixes device tree support for Origen board:
> >  - memory is defined using sections of maximum allowed size
> >  - any pin configuration is modified to use pinctrl
> >  - invalid properties in sdhci nodes are replaced according to current
> >    mmc bindings
> >  - a fixed vmmc voltage regulator is added
> >
> > Tested on Origen board.
> >
> > Depends on:
> > [PATCH v2 0/2] mmc: host: sdhci-s3c: Add support for pinctrl interface
> >
> > Tomasz Figa (4):
> >   ARM: dts: exynos4210-origen: Split memory sections
> >   ARM: dts: exynos4210-origen: Update for pinctrl-samsung driver
> >   ARM: dts: exynos4210-origen: Update sdhci nodes for current bindings
> >   ARM: dts: exynos4210-origen: Add vmmc fixed voltage regulator
> >
> >  arch/arm/boot/dts/exynos4210-origen.dts | 54
> > ++++++++++++++++----------------- 1 file changed, 27 insertions(+), 27
> > deletions(-)
> 
> Could you still pick these patches up for 3.8?
> 
Looks OK to me, I want to test 1st patch on origen board with current my
u-boot though.

Will apply, thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
