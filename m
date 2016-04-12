From: broonie@kernel.org (Mark Brown)
Date: Tue, 12 Apr 2016 07:10:07 +0100
Subject: [LINUX PATCH v2 1/3] spi: Added dummy_cycle entry in the
 spi_transfer structure.
In-Reply-To: <1460039969-9835-1-git-send-email-lakshmis@xilinx.com>
References: <1460039969-9835-1-git-send-email-lakshmis@xilinx.com>
Message-ID: <20160412061007.GY3351@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 07, 2016 at 08:09:27PM +0530, P L Sai Krishna wrote:

> + * @dummy_cycles: number of dummy cycles. If host controller requires
> + * 	dummy cycles rather than dummy bytes which send along with Cmd
> + *	and address then this dummy_cycles is used.

I'm having a very hard time parsing this, partly because it is entirely
flash specific (the whole concept of cmd and address is missing from
SPI).  As Cyrille said perhaps this should go in a flash specific
interface?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160412/2f710edd/attachment.sig>
