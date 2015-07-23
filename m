From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 23 Jul 2015 20:02:19 +0200
Subject: [PATCH] ARM: mediatek: Add regmap to mediatek Kconfig
In-Reply-To: <1437166406-14233-1-git-send-email-matthias.bgg@gmail.com>
References: <1437166406-14233-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <1437677861.d66HCIve0i@ubix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, July 17, 2015 10:53:26 PM Matthias Brugger wrote:
> Mediatek SoC needs the regmap/syscon infrastructure.
> The infrastructure is used by the clock and pinctrl driver.
> This patch adds MD_SYSCON to Kconfig for all Mediatek devices.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  arch/arm/mach-mediatek/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
> index 9f59e58..aeece17 100644
> --- a/arch/arm/mach-mediatek/Kconfig
> +++ b/arch/arm/mach-mediatek/Kconfig

applied to v4.2-next/soc
