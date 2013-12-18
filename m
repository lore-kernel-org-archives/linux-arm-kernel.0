From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 18 Dec 2013 10:29:01 -0800
Subject: [PATCHv4 0/2] CMA for arm64
In-Reply-To: <1386876513-7199-1-git-send-email-lauraa@codeaurora.org>
References: <1386876513-7199-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <52B1E96D.1060904@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2013 11:28 AM, Laura Abbott wrote:
> This adds support for CMA in arm64
>
> v4: Minor typos pointed out by Will. Changed the support for NULL devices
> to be a WARN on NULL device.
>
> v3: Fix a missed line to actually set the dma_handle correctly
>
> v2: Move the dma contiguous functions from swiotlb to arm64 directly
>
>   arch/arm64/Kconfig                      |    1 +
>   arch/arm64/include/asm/dma-contiguous.h |   29 +++++++++++++++++++++++++
>   arch/arm64/mm/dma-mapping.c             |   35 +++++++++++++++++++++++++++++-
>   arch/arm64/mm/init.c                    |    3 ++
>   4 files changed, 66 insertions(+), 2 deletions(-)
>


Any further comments on this or is this going to be queued up somewhere?

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
