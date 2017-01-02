From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 2 Jan 2017 10:49:19 +0530
Subject: [PATCH] dmaengine: ipu: Make sure the interrupt routine checks
 all interrupts.
In-Reply-To: <1482354838-22615-1-git-send-email-lilja.magnus@gmail.com>
References: <1482354838-22615-1-git-send-email-lilja.magnus@gmail.com>
Message-ID: <20170102051918.GR3573@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 21, 2016 at 10:13:58PM +0100, Magnus Lilja wrote:
> Commit 3d8cc00073d6 ("dmaengine: ipu: Consolidate duplicated irq handlers")
> consolidated the two interrupts routines into one, but the remaining
> interrupt routine only checks the status of the error interrupts, not the
> normal interrupts.
> 
> This patch fixes that problem (tested on i.MX31 PDK board).

Applied thnx

-- 
~Vinod
