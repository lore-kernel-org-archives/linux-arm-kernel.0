From: vinod.koul@intel.com (Koul, Vinod)
Date: Mon, 02 May 2011 15:44:04 +0530
Subject: [PATCH v3 1/5] dmaengine: at_hdmac: modify way to use interrupts
In-Reply-To: <35f32b2bdf51d9d5867ca352ce96d786c74a58eb.1304174965.git.nicolas.ferre@atmel.com>
References: <1303791881.896.18.camel@vkoul-udesk3>
	<35f32b2bdf51d9d5867ca352ce96d786c74a58eb.1304174965.git.nicolas.ferre@atmel.com>
Message-ID: <1304331244.1589.25.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2011-04-30 at 16:57 +0200, Nicolas Ferre wrote:
> Now we use Buffer Transfer Completed interrupts. If we
> want a chained buffer completed information, we setup the
> ATC_IEN bit in CTRLB register in the lli.
> This is done by set_desc_eol() function and used by
> memcpy/slave_sg functions.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  drivers/dma/at_hdmac.c      |    4 ++--
>  drivers/dma/at_hdmac_regs.h |   11 ++++++++---
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
All, Applied, Thanks

-- 
~Vinod
