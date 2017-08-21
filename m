From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 21 Aug 2017 21:57:31 +0530
Subject: [PATCH] ste_dma40: make stedma40_chan_cfg const
In-Reply-To: <1502630584-6844-1-git-send-email-bhumirks@gmail.com>
References: <1502630584-6844-1-git-send-email-bhumirks@gmail.com>
Message-ID: <20170821162730.GQ3053@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 13, 2017 at 06:53:04PM +0530, Bhumika Goyal wrote:
> Make these const as they are only used during a copy operation.
> Done using Coccinelle.

Pls make sure you use the right subsystem tags, hint, you cna check git log
on that subsystem/file to find the right ones

Applied after fixing the tags, thanks

-- 
~Vinod
