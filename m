From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 30 Sep 2013 17:32:12 +0200
Subject: [PATCH] ARM: mach-imx: cpu: Include <linux/err.h>
In-Reply-To: <1380550105-19372-1-git-send-email-fabio.estevam@freescale.com>
References: <1380550105-19372-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20130930153212.GD2548@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 11:08:25AM -0300, Fabio Estevam wrote:
> Commit e709f38cd7 (ARM: imx6: report soc info via soc device) causes the 
> following build error on imx_v4_v5_defconfig:
> 
> arch/arm/mach-imx/cpu.c: In function 'imx_soc_device_init':
> arch/arm/mach-imx/cpu.c:129:2: error: implicit declaration of function 'IS_ERR' [-Werror=implicit-function-declaration]
> 
> Include <linux/err.h> to fix it.
The same fix was already sent earlier: 
	http://mid.gmane.org/1380542691-24756-1-git-send-email-treding at nvidia.com

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
