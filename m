From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 01 Apr 2011 15:54:30 +0300
Subject: [PATCH 3/3] MTD/atmel_nand: Fix support for CPUs that do not
	support DMA access
In-Reply-To: <1301473601-29570-3-git-send-email-hong.xu@atmel.com>
References: <1301473601-29570-1-git-send-email-hong.xu@atmel.com>
	<1301473601-29570-3-git-send-email-hong.xu@atmel.com>
Message-ID: <1301662470.2789.59.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-03-30 at 16:26 +0800, Hong Xu wrote:
> use_dma was always "1" even if the CPU does not support DMA
> 
> Tested on AT91SAM9261EK by Jean-Christophe PLAGNIOL-VILLARD
> 
> Reported-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Signed-off-by: Hong Xu <hong.xu@atmel.com>

Pushed to l2-mtd-2.6.git tree. This looks like a candidate for the
stable tree - should it be sent there?

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
