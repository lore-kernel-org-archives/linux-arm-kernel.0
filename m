From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 10 Dec 2013 12:46:35 -0800
Subject: [PATCH v3 01/36] mtd: st_spi_fsm: Allocate resources and
 register with MTD framework
In-Reply-To: <1385727565-25794-2-git-send-email-lee.jones@linaro.org>
References: <1385727565-25794-1-git-send-email-lee.jones@linaro.org>
 <1385727565-25794-2-git-send-email-lee.jones@linaro.org>
Message-ID: <20131210204635.GD27149@ld-irv-0074.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 29, 2013 at 12:18:50PM +0000, Lee Jones wrote:
> --- /dev/null
> +++ b/drivers/mtd/devices/st_spi_fsm.c
> @@ -0,0 +1,111 @@

[...]

> +static struct of_device_id stfsm_match[] = {
> +	{ .compatible = "st,spi-fsm", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, spi_fsm_match);

s/spi_fsm_match/stfsm_match/

This doesn't compile.

Brian
