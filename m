From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Tue, 24 Jun 2014 21:29:58 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gQVJNOiBjbGstaW14NTEtaW14NTM6IFJlbW92ZSBjbGtf?=
 =?UTF-8?B?cmVnaXN0ZXJfY2xrZGV2KCkg?=
In-Reply-To: <1403629146-19245-1-git-send-email-fabio.estevam@freescale.com>
References: <1403629146-19245-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1403630998.566648963@f429.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tue, 24 Jun 2014 13:59:06 -0300 ?? Fabio Estevam <fabio.estevam@freescale.com>:
> mx51 and mx53 are device tree only platforms, so we no longer need all these
> calls to clk_register_clkdev().
> 
> Tested on imx51-babbage and imx53-qsb boards.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-imx/clk-imx51-imx53.c | 78 -------------------------------------
>  1 file changed, 78 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
...
> -	clk_register_clkdev(clk[IMX5_CLK_CPU_PODF], NULL, "cpu0");

This clock is used by cpufreq driver.

---
