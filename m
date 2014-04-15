From: dinguyen@altera.com (Dinh Nguyen)
Date: Tue, 15 Apr 2014 18:06:03 -0500
Subject: [PATCH v3 1/4] reset: add driver for socfpga
In-Reply-To: <1397548592-6384-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1397548592-6384-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1397603163.4702.0.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-04-15 at 09:56 +0200, Steffen Trumtrar wrote:
> Add a reset-controller driver for the socfpga platform.
> The reset-controller has four banks with up to 32 entries all encapsulated in
> one module block.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
> 
> Notes:
>     Changes since v2:
>     	- remove superfluous ret in probe function
>     	- add Acked-by
>     
>     Changes since v1:
>     	- use BITS_PER_LONG everywhere instead of MAX_BANK_WIDTH
>     	- print pdev->dev.of_node->full_name on error
>     	- use proper IS_ERR/PTR_ERR
> 

I've applied this series to rocketboards linux-socfpga-next/drivers and
linux-socfpga-next/next-dt.

Thanks,

Dinh
