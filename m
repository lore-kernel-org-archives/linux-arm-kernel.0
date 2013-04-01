From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 1 Apr 2013 14:41:47 +0100
Subject: [PATCH v7 03/14] spi/spi-atmel: add physical base address
In-Reply-To: <1363679016-3761-1-git-send-email-wenyou.yang@atmel.com>
References: <1363678866-3567-1-git-send-email-wenyou.yang@atmel.com>
 <1363679016-3761-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20130401134147.GV18636@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 19, 2013 at 03:43:36PM +0800, Wenyou Yang wrote:

> +++ b/drivers/spi/spi-atmel.c
> @@ -196,6 +196,7 @@ struct atmel_spi_caps {
>  struct atmel_spi {
>  	spinlock_t		lock;
>  
> +	resource_size_t		phybase;
>  	void __iomem		*regs;
>  	int			irq;
>  	struct clk		*clk;

This looks like the wrong type?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130401/e5c5ddae/attachment-0001.sig>
