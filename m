From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 9 Jul 2015 21:39:17 +0300
Subject: [PATCH v3 1/7] ARM: imx: add i.mx6ul msl support
In-Reply-To: <1436462204-32654-2-git-send-email-Frank.Li@freescale.com>
References: <1436462204-32654-1-git-send-email-Frank.Li@freescale.com>
 <1436462204-32654-2-git-send-email-Frank.Li@freescale.com>
Message-ID: <20150709183917.GK12326@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Frank,

On Fri, Jul 10, 2015 at 01:16:38AM +0800, Frank.Li at freescale.com wrote:
> +DT_MACHINE_START(IMX7D, "Freescale i.MX6 Ultralite (Device Tree)")

IMX7D?

> +	.init_irq	= imx6ul_init_irq,
> +	.init_machine	= imx6ul_init_machine,
> +	.dt_compat	= imx6ul_dt_compat,
> +MACHINE_END

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
