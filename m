From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 06 Jul 2011 09:58:11 +0300
Subject: [PATCH V2] MTD: atmel_nand: optimize read/write buffer functions
In-Reply-To: <1309789073-14593-1-git-send-email-nicolas.ferre@atmel.com>
References: <1309261856-27402-1-git-send-email-nicolas.ferre@atmel.com>
	<1309789073-14593-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <1309935496.3149.73.camel@sauron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-07-04 at 16:17 +0200, Nicolas Ferre wrote:
> For PIO NAND access functions, we use the features of the SMC:
> - no need to take into account the NAND bus width: SMC will deal with this
> - use of an IO memcpy on the NAND chip-select space is able to generate
>   proper SMC behavior.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> V2: use of memcpy_fromio/memcpy_toio for proper handling of memory types.

Pushed to l2-mtd-2.6.git, thanks!

-- 
Best Regards,
Artem Bityutskiy
