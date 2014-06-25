From: sachin.kamat@samsung.com (Sachin Kamat)
Date: Wed, 25 Jun 2014 12:04:26 +0530
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: Enable Max77686 regulator
In-Reply-To: <1403517384-24288-1-git-send-email-sachin.kamat@samsung.com>
References: <1403517384-24288-1-git-send-email-sachin.kamat@samsung.com>
Message-ID: <CAK5sBcG_FM0OAcvDh_nOxBfPDKSG+UXvvztKKyQ--Y0XNL25QQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 23, 2014 at 3:26 PM, Sachin Kamat <sachin.kamat@samsung.com> wrote:
> This is used on Exynos5250 based Google Snow (chromebook).
>
> Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
> ---
>  arch/arm/configs/multi_v7_defconfig |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 9a1e7b0c3bea..abde73eebc57 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -231,6 +231,7 @@ CONFIG_SUNXI_WATCHDOG=y
>  CONFIG_MFD_AS3722=y
>  CONFIG_MFD_CROS_EC=y
>  CONFIG_MFD_CROS_EC_SPI=y
> +CONFIG_MFD_MAX77686=y
>  CONFIG_MFD_MAX8907=y
>  CONFIG_MFD_SEC_CORE=y
>  CONFIG_MFD_PALMAS=y
> @@ -242,6 +243,7 @@ CONFIG_REGULATOR_AB8500=y
>  CONFIG_REGULATOR_AS3722=y
>  CONFIG_REGULATOR_GPIO=y
>  CONFIG_REGULATOR_MAX8907=y
> +CONFIG_REGULATOR_MAX77686=y
>  CONFIG_REGULATOR_PALMAS=y
>  CONFIG_REGULATOR_S2MPS11=y
>  CONFIG_REGULATOR_S5M8767=y
> --
> 1.7.9.5
>

Please ignore this series for now. Will re-send later after adding few more
options. Sorry for the noise.
