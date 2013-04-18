From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Apr 2013 10:48:55 +0100
Subject: [PATCH 1/10] LPC32XX: 001-mmc.1: Define + Implement
 DMA_FORCE_BURST for pl032
In-Reply-To: <E1USZCP-0006Pl-UO@merlin.infradead.org>
References: <E1USZCP-0006Pl-UO@merlin.infradead.org>
Message-ID: <20130418094855.GJ14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 17, 2013 at 10:42:49PM +0200, Cedric Berger wrote:
> Signed-off-by: Gabriele Mondada <gabriele@precidata.com>
> ---
> To implement the MMC driver on LPC32xx, we need a way to force a DMA burst by
> software. This patch defines a new DMA_FORCE_BURST hook and implements it for
> the pl08x.c

The above should be in the commit comments.  Also, consider copying Vinod
as this augments the DMA engine interface.
