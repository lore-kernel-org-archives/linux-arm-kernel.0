From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 2 May 2014 21:21:33 +0530
Subject: [PATCH 3/6] dma: mmp_pdma: Simplify access to channel drcmr value
In-Reply-To: <1397574817-15559-4-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1397574817-15559-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <1397574817-15559-4-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <20140502155133.GV32284@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 05:13:34PM +0200, Laurent Pinchart wrote:
> As the physical channel and virtual channel point to each other,
> pchan->phy->vchan is always equal to pchan. Simplify the code
> accordingly.
> 
Applied, thanks

-- 
~Vinod
