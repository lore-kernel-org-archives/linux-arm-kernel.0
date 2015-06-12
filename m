From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 12 Jun 2015 18:31:34 +0530
Subject: [PATCH] dmaengine: fsl-edma: clear pending interrupts on
 initialization
In-Reply-To: <1433706370-3867-1-git-send-email-stefan@agner.ch>
References: <1433706370-3867-1-git-send-email-stefan@agner.ch>
Message-ID: <20150612130134.GK28601@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 07, 2015 at 09:46:10PM +0200, Stefan Agner wrote:
> Clear pending interrupts before requesting interrupts and move
> interrupt initialization after channels have been initialized.
> This avoids a NULL pointer dereference panic when using kexec
> while DMA requests were running.

Applied, thanks

-- 
~Vinod
