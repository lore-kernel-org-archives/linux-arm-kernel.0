From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 2 May 2014 21:22:03 +0530
Subject: [PATCH 4/6] dma: mmp_pdma: Fix physical channel memory
 allocation size
In-Reply-To: <1397574817-15559-5-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1397574817-15559-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <1397574817-15559-5-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <20140502155203.GW32284@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 05:13:35PM +0200, Laurent Pinchart wrote:
> Use sizeof(*var) instead of sizeof(type) when calling devm_k*alloc().
> This avoids using the wrong type as was done to allocate the physical
> channels array.
>

Applied, thanks

-- 
~Vinod
