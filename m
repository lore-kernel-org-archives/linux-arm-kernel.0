From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 12 Apr 2011 10:08:51 +0200
Subject: [PATCH 1/6] ARM: mxc: update defconfigs
In-Reply-To: <20110412075931.GA24855@S2100-06.ap.freescale.net>
References: <1302464943-20721-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110412075931.GA24855@S2100-06.ap.freescale.net>
Message-ID: <20110412080851.GG7771@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2011 at 03:59:32PM +0800, Shawn Guo wrote:
> Hi Uwe,
> 
> On Sun, Apr 10, 2011 at 09:48:58PM +0200, Uwe Kleine-K?nig wrote:
> > 
> [...]
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  arch/arm/configs/mx1_defconfig  |   11 +++-----
> >  arch/arm/configs/mx21_defconfig |    8 +++---
> >  arch/arm/configs/mx27_defconfig |   45 ++++++++++++++++++++++++++++----
> >  arch/arm/configs/mx3_defconfig  |   40 +++++++++++++++++++++--------
> >  arch/arm/configs/mx51_defconfig |   53 +++++++++++++++++++++++++++++++-------
> 
> Would you consider to enable mx5 ESDHC by default?  I guess Linaro
> will appreciate it, as they are using ext3 rootfs on SD/MMC for their
> releases.
I assume this means

	+CONFIG_MMC_SDHCI_PLTFM=m
	+CONFIG_MMC_SDHCI_ESDHC_IMX=y

seems sensible for mx3, too. I will look after that.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
