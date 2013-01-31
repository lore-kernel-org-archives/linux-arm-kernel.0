From: mporter@ti.com (Matt Porter)
Date: Wed, 30 Jan 2013 20:32:15 -0500
Subject: [PATCH v6 09/10] spi: omap2-mcspi: add generic DMA request
 support to the DT binding
In-Reply-To: <201301300924.00508.arnd@arndb.de>
References: <1359529229-22207-1-git-send-email-mporter@ti.com>
 <1359529229-22207-10-git-send-email-mporter@ti.com>
 <201301300924.00508.arnd@arndb.de>
Message-ID: <20130131013215.GF2244@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 09:24:00AM +0000, Arnd Bergmann wrote:
> On Wednesday 30 January 2013, Matt Porter wrote:
> > +Optional properties:
> > +- dmas: List of DMA controller phandle and DMA request ordered
> > +       pairs. One tx and one rx pair is required for each chip
> > +       select.
> 
> The binding looks ok, but the wording is slightly incorrect here:
> strictly speaking, it's not a pair of controller phandle and request
> line number, but a DMA descriptor as specified in bindings/dma/dma.txt
> with a format specific to the dma engine being used. That can
> require more than just a single integer request number.

Correct. I will update accordingly.

-Matt
