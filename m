From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 17 Jul 2014 11:23:19 +0100
Subject: [PATCH 2/4] arm64: use generic dma-contiguous.h
In-Reply-To: <1405525892-60383-3-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1405525892-60383-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1405525892-60383-3-git-send-email-Zubair.Kakakhel@imgtec.com>
Message-ID: <20140717102318.GC18203@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 04:51:30PM +0100, Zubair Lutfullah Kakakhel wrote:
> dma-contiguous.h is now in asm-generic. Use that to avoid code
> repetition in arm64.
> 
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> ---
>  arch/arm64/include/asm/Kbuild           |  1 +
>  arch/arm64/include/asm/dma-contiguous.h | 28 ----------------------------
>  2 files changed, 1 insertion(+), 28 deletions(-)
>  delete mode 100644 arch/arm64/include/asm/dma-contiguous.h

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
