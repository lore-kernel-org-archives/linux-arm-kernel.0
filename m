From: ritesh.harjani@gmail.com (Ritesh Harjani)
Date: Wed, 23 Apr 2014 10:59:45 +0530
Subject: arm64: default dma_ops is set to coherent_dma_ops results into DMA
 FAILURE
In-Reply-To: <20140422152152.GG9820@arm.com>
References: <20140422152152.GG9820@arm.com>
Message-ID: <1398230986-2823-1-git-send-email-ritesh.harjani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will/Catalin, 

Thanks for explaining this. As you guys said we can
default to noncoherent ops for arm64 as well, I am
submitting this patch for the same.

Catalin, as you said that there are no current dma-capable
driver which assumes coherent ops, so I guess this will not
break anything.

Ritesh Harjani (1):
  arm64: Make default dma_ops to be noncoherent

 arch/arm64/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.8.1.3
