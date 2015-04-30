From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Thu, 30 Apr 2015 13:16:53 +0200
Subject: [STLinux Kernel] [PATCH v7 2/9] ARM: multi_v7_defconfig: Enable
 support for ST's LPC Watchdog
In-Reply-To: <1428590854-14095-3-git-send-email-lee.jones@linaro.org>
References: <1428590854-14095-1-git-send-email-lee.jones@linaro.org>
 <1428590854-14095-3-git-send-email-lee.jones@linaro.org>
Message-ID: <55420F25.2080205@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/09/2015 04:47 PM, Lee Jones wrote:
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   arch/arm/configs/multi_v7_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index b7e6b6fb..138e68a 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -324,6 +324,7 @@ CONFIG_WATCHDOG=y
>   CONFIG_XILINX_WATCHDOG=y
>   CONFIG_ARM_SP805_WATCHDOG=y
>   CONFIG_ORION_WATCHDOG=y
> +CONFIG_ST_LPC_WATCHDOG=y
>   CONFIG_SUNXI_WATCHDOG=y
>   CONFIG_MESON_WATCHDOG=y
>   CONFIG_MFD_AS3711=y
Applied to sti_defconfig-for_v4.2.

Thanks!
Maxime
