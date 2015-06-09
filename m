From: broonie@kernel.org (Mark Brown)
Date: Tue, 9 Jun 2015 18:26:00 +0100
Subject: [PATCH v3 1/3] spi: atmel: add support for the internal
 chip-select of the spi controller
In-Reply-To: <c05f4d9abfdabb62b3b3cfeb57a3f9c138b4e45d.1433850255.git.cyrille.pitchen@atmel.com>
References: <cover.1433850255.git.cyrille.pitchen@atmel.com>
 <c05f4d9abfdabb62b3b3cfeb57a3f9c138b4e45d.1433850255.git.cyrille.pitchen@atmel.com>
Message-ID: <20150609172600.GN14071@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 09, 2015 at 01:53:52PM +0200, Cyrille Pitchen wrote:
> This patch relies on the CSAAT (Chip Select Active After Transfer) feature
> introduced by the version 2 of the spi controller. This new mode allows to
> use properly the internal chip-select output pin of the spi controller
> instead of using external gpios. Consequently, the "cs-gpios" device-tree
> property becomes optional.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150609/0464e995/attachment.sig>
