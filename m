From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Tue, 27 Nov 2018 22:36:41 +0100
Subject: [PATCH 3/4] defconfig: arm64: add i.MX system controller RTC
 support
In-Reply-To: <1543311334-8807-4-git-send-email-Anson.Huang@nxp.com>
References: <1543311334-8807-1-git-send-email-Anson.Huang@nxp.com>
 <1543311334-8807-4-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20181127213641.GC7569@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/11/2018 09:41:37+0000, Anson Huang wrote:
> This patch enables CONFIG_RTC_DRV_IMX_SC by default.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 6d224f7..6fdf2d0 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -573,6 +573,7 @@ CONFIG_RTC_DRV_PL031=y
>  CONFIG_RTC_DRV_SUN6I=y
>  CONFIG_RTC_DRV_ARMADA38X=y
>  CONFIG_RTC_DRV_TEGRA=y
> +CONFIG_RTC_DRV_IMX_SC=y

I think this has to be m unless you need the RTC to be able to boot.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
