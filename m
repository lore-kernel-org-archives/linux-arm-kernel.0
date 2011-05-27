From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 26 May 2011 20:42:38 -0500
Subject: [PATCH 4/5] ep93xx: remove the old M2P DMA code
In-Reply-To: <f4ecbf118a8478e4df2da7b8a5e9b4330892679b.1306082097.git.mika.westerberg@iki.fi>
References: <cover.1306082097.git.mika.westerberg@iki.fi>
	<f4ecbf118a8478e4df2da7b8a5e9b4330892679b.1306082097.git.mika.westerberg@iki.fi>
Message-ID: <0D753D10438DA54287A00B027084269764D331A4B4@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, May 22, 2011 10:03 AM, Mika Westerberg wrote:
>
> Since we have converted all existing users of the old DMA API to use the DMA
> engine API the old code can be dropped.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
> ---
>  arch/arm/mach-ep93xx/Makefile           |    2 +-
>  arch/arm/mach-ep93xx/dma-m2p.c          |  411 -------------------------------
>  arch/arm/mach-ep93xx/include/mach/dma.h |  143 -----------
>  3 files changed, 1 insertions(+), 555 deletions(-)
>  delete mode 100644 arch/arm/mach-ep93xx/dma-m2p.c

Other than my comment in patch 1/5 about the old driver being builtin...

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
