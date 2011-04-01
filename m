From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 01 Apr 2011 16:36:42 +0300
Subject: [PATCH 1/3 v2] MTD: atmel_nand: modify test case for using DMA
	operations
In-Reply-To: <1301668844-4500-1-git-send-email-nicolas.ferre@atmel.com>
References: <1301662188.2789.57.camel@localhost>
	<1301668844-4500-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <1301665002.2789.75.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-04-01 at 16:40 +0200, Nicolas Ferre wrote:
> We have better performances not using DMA for oob operations.
> Modify size test so that it is using DMA for size greater than oobsize.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Pushed to l2-mtd-2.6.git, thank you!

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
