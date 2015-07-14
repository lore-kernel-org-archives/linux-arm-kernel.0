From: broonie@kernel.org (Mark Brown)
Date: Tue, 14 Jul 2015 17:28:06 +0100
Subject: [RFC PATCH 2/2] spi: zynqmp: gqspi: add support for stacked mode
 configuration
In-Reply-To: <1436445895-25504-3-git-send-email-ranjit.waghmode@xilinx.com>
References: <1436445895-25504-1-git-send-email-ranjit.waghmode@xilinx.com>
 <1436445895-25504-3-git-send-email-ranjit.waghmode@xilinx.com>
Message-ID: <20150714162806.GD11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 09, 2015 at 06:14:55PM +0530, Ranjit Waghmode wrote:
> This patch adds support of stacked mode configuration for
> Zynq Ultrascale+ MPSoC GQSPI controller driver.

> +	} else if (qspi->master->flags & SPI_MASTER_U_PAGE) {

Same here, there's no definition of SPI_MASTER_U_PAGE.  It doesn't sound
very generic but I'm not entirely sure what "stacked mode" is.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150714/7fcc581a/attachment-0001.sig>
