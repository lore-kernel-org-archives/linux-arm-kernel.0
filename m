From: shannon.zhao@linaro.org (Shannon Zhao)
Date: Thu, 04 Jun 2015 22:08:56 +0800
Subject: [PATCH] ARM64: add GPIO keys to the defconfig
In-Reply-To: <1433418101-10367-1-git-send-email-linus.walleij@linaro.org>
References: <1433418101-10367-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <55705BF8.7010904@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/6/4 19:41, Linus Walleij wrote:
> The Juno board, and likely many other boards, likes to use simple
> GPIO keys for input events. Enabled this in the default
> ARM64 defconfig.
>

This is also useful for QEMU to support external poweroff on ARM.

Reviewed-by: Shannon Zhao <shannon.zhao@linaro.org>

> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Hi ARM SoC folks, please apply this directly to the defconfig
> branch so we can have GPIO keys on our ARM64 machines.
> ---
>   arch/arm64/configs/defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 2ed7449d9273..b8760c31d0d3 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -94,6 +94,7 @@ CONFIG_SMC91X=y
>   CONFIG_SMSC911X=y
>   # CONFIG_WLAN is not set
>   CONFIG_INPUT_EVDEV=y
> +CONFIG_KEYBOARD_GPIO=y
>   # CONFIG_SERIO_SERPORT is not set
>   CONFIG_SERIO_AMBAKMI=y
>   CONFIG_LEGACY_PTY_COUNT=16
>

-- 
Shannon
