From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 2 Jun 2014 14:37:04 +0800
Subject: [PATCH v3 0/7] of: setup dma parameters using dma-ranges and
 dma-coherent
In-Reply-To: <1398353407-2345-1-git-send-email-santosh.shilimkar@ti.com>
References: <1398353407-2345-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20140602063702.GB7834@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 11:30:00AM -0400, Santosh Shilimkar wrote:
> Here is an updated v3 of the series. Series introduces support for setting up
> dma parameters based on device tree properties like 'dma-ranges' and
> 'dma-coherent' and also update to ARM 32 bit port. Earlier version of the
> series can be found here [3], [2] and [1].

Are these two generic device tree properties documented somewhere under
Documentation/devicetree/bindings?

Shawn
