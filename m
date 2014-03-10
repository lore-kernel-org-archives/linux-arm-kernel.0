From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Mar 2014 10:34:14 +0000
Subject: [PATCH 5/5] ARM: multi_v7_defconfig: add st-keyscan driver
In-Reply-To: <1393990772-9567-6-git-send-email-gabriel.fernandez@st.com>
References: <1393990772-9567-1-git-send-email-gabriel.fernandez@st.com>
 <1393990772-9567-6-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20140310103414.GH14976@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This patch adds KEYBOARD_ST_KEYSCAN config
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)

You should capitalise ST Keyscan in the $SUBJECT line, but other than that:
  Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index ee69829..5e926981 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -131,6 +131,7 @@ CONFIG_INPUT_EVDEV=y
>  CONFIG_KEYBOARD_GPIO=y
>  CONFIG_KEYBOARD_TEGRA=y
>  CONFIG_KEYBOARD_SPEAR=y
> +CONFIG_KEYBOARD_ST_KEYSCAN=y
>  CONFIG_KEYBOARD_CROS_EC=y
>  CONFIG_MOUSE_PS2_ELANTECH=y
>  CONFIG_INPUT_MISC=y

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
