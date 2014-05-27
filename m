From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 May 2014 20:36:32 +0200
Subject: [PATCH v1 3/5] phy: pci serdes phy driver for keystone
In-Reply-To: <5384C17E.5060806@ti.com>
References: <1400169692-9677-1-git-send-email-m-karicheri2@ti.com>
 <9828919.7tZBgbvqj4@wuerfel> <5384C17E.5060806@ti.com>
Message-ID: <4735720.XlAWNkHzF3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 May 2014 12:46:54 Murali Karicheri wrote:
> I have checked the register set of the following drivers under 
> drivers/phy from the
> master branch (v3.15-rc6) using the registers set available with us 
> internally and
> I can't find a match.
> 
> phy-exynos5250-sata.c  phy-exynos-mipi-video.c  phy-omap-usb2.c 
> phy-sun4i-usb.c
> phy-xgene.c phy-exynos4210-usb2.c  phy-exynos5250-usb2.c phy-mvebu-sata.c
> phy-samsung-usb2.c  phy-ti-pipe3.c phy-bcm-kona-usb2.c phy-exynos4x12-usb2.c
>   phy-exynos-dp-video.c  phy-omap-control.c  phy-twl4030-usb.c
> 
> So there is no duplication.

Ok, thanks a lot for checking!

	Arnd
