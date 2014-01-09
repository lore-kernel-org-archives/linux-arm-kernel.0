From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 9 Jan 2014 15:21:34 -0200
Subject: [PATCHv9][ 1/3] ARM i.MX35: build in pinctrl support.
In-Reply-To: <1389287716-12802-1-git-send-email-denis@eukrea.com>
References: <1389287716-12802-1-git-send-email-denis@eukrea.com>
Message-ID: <CAOMZO5DBiX0gN249M7AN=GX4UCTie0m2CBAdCtvAdn4uKafwzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 9, 2014 at 3:15 PM, Denis Carikli <denis@eukrea.com> wrote:

> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index b0c6eb3..2586eab 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -125,6 +125,8 @@ config SOC_IMX35
>         select CPU_V6K
>         select HAVE_EPIT
>         select MXC_AVIC
> +       select PINCTRL

You select PINCTRL here ...

> +       select PINCTRL_IMX35
>         select SMP_ON_UP if SMP
>         select PINCTRL

,but it is already selected.

Regards,

Fabio Estevam
