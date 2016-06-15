From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 15 Jun 2016 11:27:46 -0700
Subject: [PATCH] arm64: defconfig: enable stmmac and realtek PHY as modules
In-Reply-To: <1464993495-19018-1-git-send-email-khilman@baylibre.com>
References: <1464993495-19018-1-git-send-email-khilman@baylibre.com>
Message-ID: <CAOi56cUGq87cEm0uhfVS=tVnwPoUCKVF5YX-G0Z_wW_zezYXfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin, Will,

On Fri, Jun 3, 2016 at 3:38 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> Some Amlogic GXBB boards use the stmmac ethernet driver.  Also, enable
> the realtek PHY used on meson-gxbb-odroidc2.  The micrel PHY used on the
> meson-gxbb-p20x boards is already enabled.
>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>

Gentle reminder ping.

Thanks,

Kevin

> ---
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index fd2d74d0491e..987a6158c19d 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -127,6 +127,8 @@ CONFIG_SKY2=y
>  CONFIG_RAVB=y
>  CONFIG_SMC91X=y
>  CONFIG_SMSC911X=y
> +CONFIG_STMMAC_ETH=m
> +CONFIG_REALTEK_PHY=m
>  CONFIG_MICREL_PHY=y
>  CONFIG_USB_PEGASUS=m
>  CONFIG_USB_RTL8150=m
> --
> 2.7.4
>
