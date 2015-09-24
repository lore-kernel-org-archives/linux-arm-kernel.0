From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 24 Sep 2015 22:58:08 +0530
Subject: [PATCH] dmaengine: pxa_dma: fix initial list move
In-Reply-To: <1442826392-9082-1-git-send-email-robert.jarzmik@free.fr>
References: <1442826392-9082-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20150924172808.GE2381@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 21, 2015 at 11:06:32AM +0200, Robert Jarzmik wrote:
> Since the commit to have an allocated list of virtual descriptors was
> reverted, the pxa_dma driver is broken, as it assumes the descriptor is
> placed on the allocated list upon allocation.
> 
> Fix the issue in pxa_dma by making an allocated virtual descriptor a
> singleton.

This seems okay, simpler and safer. Do you want me to apply this instead
while detailed approach can be reviewed and discussed

-- 
~Vinod
