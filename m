From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 30 Nov 2015 15:28:26 +0100
Subject: [PATCH 2/2] ARM: mvebu: add Kirkwood cpuidle to defconfig
In-Reply-To: <1448461045-16772-1-git-send-email-linus.walleij@linaro.org>
 (Linus Walleij's message of "Wed, 25 Nov 2015 15:17:25 +0100")
References: <1448461045-16772-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <871tb75zp1.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,
 
 On mer., nov. 25 2015, Linus Walleij <linus.walleij@linaro.org> wrote:

> The Kirkwood v5 platforms need their CPUIDLE driver, so put it
> into the defconfig.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied on mvebu/defconfig

Thanks,

Gregory

> ---
>  arch/arm/configs/mvebu_v5_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
> index 519c72725798..aa9079c84024 100644
> --- a/arch/arm/configs/mvebu_v5_defconfig
> +++ b/arch/arm/configs/mvebu_v5_defconfig
> @@ -25,6 +25,7 @@ CONFIG_CPU_FREQ=y
>  CONFIG_CPU_FREQ_STAT_DETAILS=y
>  CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
>  CONFIG_CPU_IDLE=y
> +CONFIG_ARM_KIRKWOOD_CPUIDLE=y
>  CONFIG_NET=y
>  CONFIG_PACKET=y
>  CONFIG_UNIX=y
> -- 
> 2.4.3
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
