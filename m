From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 12 Mar 2015 21:00:53 +0900
Subject: [PATCH] ARM: exynos_defconfig: Enable Marvell WiFi-Ex support
In-Reply-To: <1423992532-29228-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1423992532-29228-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <02cf01d05cbc$30ab15b0$92014110$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martinez Canillas wrote:
> 
> Exynos5420 Peach Pit and Exynos5800 Peach Pi boards have a MMC/SDIO
> Marvell WiFi-Ex chip. This patch enables wireless support and the
> mwifiex driver.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  arch/arm/configs/exynos_defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index 70e5d0bdb4e4..dcef516bcd0d 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -34,6 +34,10 @@ CONFIG_PACKET=y
>  CONFIG_UNIX=y
>  CONFIG_NET_KEY=y
>  CONFIG_INET=y
> +CONFIG_WIRELESS=y
> +CONFIG_CFG80211=y
> +CONFIG_MWIFIEX=y
> +CONFIG_MWIFIEX_SDIO=y
>  CONFIG_RFKILL_REGULATOR=y
>  CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>  CONFIG_DEVTMPFS=y
> --

OK, will apply.

Thanks,
Kukjin
