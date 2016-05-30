From: broonie@kernel.org (Mark Brown)
Date: Mon, 30 May 2016 18:38:39 +0100
Subject: [PATCH v2 3/3] spi: xilinx: Update devicetree bindings for
 spi-xilinx
In-Reply-To: <1464601627-5246-1-git-send-email-nagasure@xilinx.com>
References: <1464601627-5246-1-git-send-email-nagasure@xilinx.com>
Message-ID: <20160530173839.GA29837@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2016 at 03:17:07PM +0530, Naga Sureshkumar Relli wrote:

> Update bindings for spi-xilinx.
> as per spi-bus.txt rename num-ss-bits to num-cs.
> and add fifo-size and bits-per-word properties.

This makes the new bindings backwards incompatible breaking existing
machine descriptions.  It's fine to add new options but the driver
should accept the old options.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160530/fb69d58a/attachment.sig>
