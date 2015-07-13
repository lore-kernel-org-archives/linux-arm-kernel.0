From: broonie@kernel.org (Mark Brown)
Date: Mon, 13 Jul 2015 15:59:07 +0100
Subject: [RFC PATCH 0/2] spi: add dual parallel & stacked mode support in
 Zynq MPSoC GQSPI controller
In-Reply-To: <559F824B.70409@topic.nl>
References: <1436445895-25504-1-git-send-email-ranjit.waghmode@xilinx.com>
 <559F824B.70409@topic.nl>
Message-ID: <20150713145907.GF11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 10, 2015 at 10:28:59AM +0200, Mike Looijmans wrote:
> ?On 09-07-15 14:44, Ranjit Waghmode wrote:

> >ZynqMP GQSPI controller supports stacked mode with following functionalities:
> >1) The Generic Quad-SPI controller also supports two SPI flash memories
> >    in a shared bus arrangement to reduce IO pin count.
> >2) Separate chip select lines
> >3) Shared I/O lines
> >4) This mode is targeted for increasing the flash memory and no performance
> >    improvement when compared with single.

> One could also model the stacked mode as having two distinct flash chips
> with separate chip selects and shared lines.

Well, quite.  I'm confused about how the above differs from a just a SPI
controller with two chip selects which is perfectly standard.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150713/da9eee36/attachment.sig>
