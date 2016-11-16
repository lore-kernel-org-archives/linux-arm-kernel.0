From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 16 Nov 2016 08:56:20 +0530
Subject: [PATCH 0/8] DMA: s3c64xx: Conversion to the new channel request
 API
In-Reply-To: <1478791076-19528-1-git-send-email-s.nawrocki@samsung.com>
References: <1478791076-19528-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20161116032620.GV3000@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2016 at 04:17:48PM +0100, Sylwester Nawrocki wrote:
> This patch series aims to convert the s3c64xx platform to use
> the new DMA channel request API, i.e. this is only meaningful 
> for non-dt systems using s3c64xx SoCs.
> 
> Presumably the first 2 or 4 patches in this series could be queued 
> for v4.10-rc1 and the remaining patches could be left for subsequent
> release, to avoid non-trivial conflict with patches already applied 
> in the ASoC tree.

I am fine with dma patch (expect the subsystem tag) and others except arm
ones have acks, so I think we can merge this for v4.10-rc1. I cna create a
immutable tag and people can merge into their tree in case they have
dependencies.

Btw need acks on ARM patches before I can apply

Thanks

-- 
~Vinod
