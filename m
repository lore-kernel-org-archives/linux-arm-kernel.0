From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 4 Aug 2014 13:44:12 +0530
Subject: [PATCH] dmaengine: Remove the context argument to the
 prep_dma_cyclic operation
In-Reply-To: <1406888410-14504-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1406888410-14504-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <20140804081412.GM8181@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 01, 2014 at 12:20:10PM +0200, Laurent Pinchart wrote:
> The argument is always set to NULL and never used. Remove it.
> 
Applied now, Thanks

-- 
~Vinod
