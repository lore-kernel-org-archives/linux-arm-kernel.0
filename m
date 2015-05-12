From: broonie@kernel.org (Mark Brown)
Date: Tue, 12 May 2015 20:19:05 +0100
Subject: [PATCH] spi: omap2-mcspi: Fix native cs with new set_cs
In-Reply-To: <55524D20.2050203@ti.com>
References: <1431452337-19280-1-git-send-email-mwelling@ieee.org>
 <55524D20.2050203@ti.com>
Message-ID: <20150512191905.GY3066@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 01:57:36PM -0500, Nishanth Menon wrote:
> On 05/12/2015 12:38 PM, Michael Welling wrote:
> > GPIO chip select patch series appears to have broken the native chip select
> > support. This patch pulls the manual native chip select toggling out of
> > the transfer_one routine and adds a set_cs routine.

Please remember to delete unneeded context from your replies, the reader
shouldn't need to page through the entire patch to find out you reviewed
it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150512/c9bea297/attachment.sig>
