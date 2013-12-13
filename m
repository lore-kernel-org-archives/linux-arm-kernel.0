From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu, 12 Dec 2013 16:48:27 -0800
Subject: [PATCH 3/3] swiotlb: Add support for CMA allocations
In-Reply-To: <20131210104231.GB2521@darko.cambridge.arm.com>
References: <1386634334-31139-1-git-send-email-lauraa@codeaurora.org>
 <1386634334-31139-4-git-send-email-lauraa@codeaurora.org>
 <1da8f502-0e34-4b54-929e-bcbe40b20b7f@email.android.com>
 <52A66211.6010707@codeaurora.org>
 <83dd58eb-9a44-4b76-aa68-4669b26acab8@email.android.com>
 <20131210102555.GB2338@mudshark.cambridge.arm.com>
 <20131210104231.GB2521@darko.cambridge.arm.com>
Message-ID: <52AA595B.7090708@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/2013 2:42 AM, Catalin Marinas wrote:
>
> For coherency, we could build it on top of whatever dma (allocation) ops
> are registered, whether swiotlb or iommu (see part of
> https://git.kernel.org/cgit/linux/kernel/git/cmarinas/linux-aarch64.git/commit/?h=devel&id=c67fe405be6b55399c9e53dfeba5e2c6b930e429)
>
> Regarding iommu, I don't think we need CMA on top, so it makes sense to
> keep the CMA in the swiotlb code.
>

Catalin, is that just sample/design code or is that patch going to be 
merged sometime?

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
