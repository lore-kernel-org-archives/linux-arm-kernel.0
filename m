From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 18 Oct 2016 20:15:31 +0530
Subject: [PATCH] Revert "dmaengine: pxa_dma: add support for legacy
 transition"
In-Reply-To: <1476773192-23715-1-git-send-email-robert.jarzmik@free.fr>
References: <1476773192-23715-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20161018144531.GY2467@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2016 at 08:46:32AM +0200, Robert Jarzmik wrote:
> This reverts commit c91134d9194478144ba579ca6efeddf628055650.
> 
> The conversion of the pxa architecture is now finished for all
> drivers, so this functions has fullfilled its purpose and can
> now be removed.

Applied, thanks

-- 
~Vinod
