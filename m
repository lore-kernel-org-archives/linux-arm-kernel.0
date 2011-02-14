From: dan.j.williams@intel.com (Dan Williams)
Date: Mon, 14 Feb 2011 02:26:30 -0800
Subject: [PATCH 0/6] A few fixes on imx-sdma
In-Reply-To: <20110131120328.GL9041@pengutronix.de>
References: <1295473840-17295-1-git-send-email-shawn.guo@freescale.com>
	<20110131120328.GL9041@pengutronix.de>
Message-ID: <AANLkTi=guhXU9pV4pK17Y0c0nRMcy4oXC9PAKxD27jDj@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 31, 2011 at 4:03 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Thu, Jan 20, 2011 at 05:50:34AM +0800, Shawn Guo wrote:
>> The patch set is to address the concerns discussed on thread below.
>> And it's been tested on mx51 babbage board with sound driver.
>>
>> "A few questions on imx-sdma"
>> http://article.gmane.org/gmane.linux.ports.arm.kernel/103001/
>>
>> Shawn Guo (6)
>> ?drivers/dma/imx-sdma.c | ? 31 +++++++++++++++++++------------
>> ?1 files changed, 19 insertions(+), 12 deletions(-)
>>
>> ?[PATCH 1/6] dmaengine: imx-sdma: remove IMX_DMA_SG_LOOP handling in sdma_prep_slave_sg()
>> ?[PATCH 2/6] dmaengine: imx-sdma: set sdmac->status to DMA_ERROR in err_out of sdma_prep_slave_sg()
>> ?[PATCH 3/6] dmaengine: imx-sdma: return sdmac->status in sdma_tx_status()
>> ?[PATCH 4/6] dmaengine: imxs-sdma: correct sdmac->status in sdma_handle_channel_loop()
>> ?[PATCH 5/6] dmaengine: imx-sdma: fix up param for the last BD in sdma_prep_slave_sg()
>
> Patches 1/6 - 5/6:
>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
>
> Dan,
>
> For your convenience I've set up a branch containing Shawns patches and
> the ones just posted here:

Thanks, I'll take this.  One nit please try to avoid
one-line/subject-only commit messages.

--
Dan
