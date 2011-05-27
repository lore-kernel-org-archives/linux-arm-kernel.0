From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 26 May 2011 20:44:37 -0500
Subject: [PATCH 2/5] ep93xx: add dmaengine platform code
In-Reply-To: <e903b474448f984f024682b1f565e8ef23c3b842.1306082097.git.mika.westerberg@iki.fi>
References: <cover.1306082097.git.mika.westerberg@iki.fi>
	<e903b474448f984f024682b1f565e8ef23c3b842.1306082097.git.mika.westerberg@iki.fi>
Message-ID: <0D753D10438DA54287A00B027084269764D331A4B6@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, May 22, 2011 10:03 AM, Mika Westerberg wrote:
> 
> Add platform support code for the new EP93xx dmaengine driver.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
> ---
>  arch/arm/mach-ep93xx/Makefile |    2 +-
>  arch/arm/mach-ep93xx/dma.c    |  108 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 109 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-ep93xx/dma.c

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
