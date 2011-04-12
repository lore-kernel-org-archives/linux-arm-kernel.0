From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 12 Apr 2011 15:59:32 +0800
Subject: [PATCH 1/6] ARM: mxc: update defconfigs
In-Reply-To: <1302464943-20721-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1302464943-20721-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20110412075931.GA24855@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Sun, Apr 10, 2011 at 09:48:58PM +0200, Uwe Kleine-K?nig wrote:
> 
[...]
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/configs/mx1_defconfig  |   11 +++-----
>  arch/arm/configs/mx21_defconfig |    8 +++---
>  arch/arm/configs/mx27_defconfig |   45 ++++++++++++++++++++++++++++----
>  arch/arm/configs/mx3_defconfig  |   40 +++++++++++++++++++++--------
>  arch/arm/configs/mx51_defconfig |   53 +++++++++++++++++++++++++++++++-------

Would you consider to enable mx5 ESDHC by default?  I guess Linaro
will appreciate it, as they are using ext3 rootfs on SD/MMC for their
releases.

-- 
Regards,
Shawn
