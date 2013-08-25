From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 25 Aug 2013 22:05:39 +0530
Subject: [PATCH v5 0/5] dma: pdma: cyclic, residue, DMA_PRIVATE
In-Reply-To: <1377086938-29145-1-git-send-email-zonque@gmail.com>
References: <1377086938-29145-1-git-send-email-zonque@gmail.com>
Message-ID: <20130825163539.GE2748@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 21, 2013 at 02:08:53PM +0200, Daniel Mack wrote:
> This is v5 of my series to teach the pdma driver more required functions.
> 
> In contrast to v4, it has yet again grown by one more patch (2/5),
> which removes code that clears DCMD_ENDIRQEN at the end of the pending
> chain. We want to leave of the DCMD_ENDIRQEN intact in order to
> identify where a transaction ends.
Applied, 1-3 & 5. The 4th one still needs some work

~Vinod
