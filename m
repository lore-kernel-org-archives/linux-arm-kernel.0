From: broonie@kernel.org (Mark Brown)
Date: Tue, 14 Jul 2015 17:26:27 +0100
Subject: [RFC PATCH 1/2] spi: zynqmp: gqspi: add support for dual
 parallel mode configuration
In-Reply-To: <1436445895-25504-2-git-send-email-ranjit.waghmode@xilinx.com>
References: <1436445895-25504-1-git-send-email-ranjit.waghmode@xilinx.com>
 <1436445895-25504-2-git-send-email-ranjit.waghmode@xilinx.com>
Message-ID: <20150714162627.GC11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 09, 2015 at 06:14:54PM +0530, Ranjit Waghmode wrote:

> +	if (qspi->master->flags & SPI_BOTH_FLASH) {

There's currently no SPI_BOTH_FLASH...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150714/f7a86762/attachment.sig>
