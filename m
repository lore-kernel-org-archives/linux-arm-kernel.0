From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Thu, 08 May 2014 17:59:36 +0200
Subject: [PATCH 1/2] ARM: dts: Enable USB 3503 hub on exynos5250-snow
In-Reply-To: <1399293056-17143-1-git-send-email-gautam.vivek@samsung.com>
References: <1399293056-17143-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <536BA9E8.2030306@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Am 05.05.2014 14:30, schrieb Vivek Gautam:
> The exynos5250-snow has a SMSC USB3503 connected in
> hardware only mode like a PHY. Enable support for it,
> and add necessary 'reset-gpio' for it.
> 
> This is in correspondance to similar patch by Mark Brown
> 7c1b0ec ARM: dts: Enable USB hub on Arndale
> 
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> ---
> 
> Based on 'for-next' branch of kgene's linux-samsung tree.
> 
>  arch/arm/boot/dts/exynos5250-pinctrl.dtsi |    7 +++++++
>  arch/arm/boot/dts/exynos5250-snow.dts     |   14 ++++++++++++++
>  2 files changed, 21 insertions(+)

The same snippet as for snow also fixed my USB issues on spring.
Should it go into exynos5250-cros-common.dtsi instead?

Regards,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
