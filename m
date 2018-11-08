From: broonie@kernel.org (Mark Brown)
Date: Thu, 8 Nov 2018 12:07:52 +0000
Subject: Applied "spi: Add QuadSPI driver for Atmel SAMA5D2" to the spi
 tree
In-Reply-To: <20181108095022.66ad3ad1@bbrezillon>
References: <20181105103625.9644-6-bugalski.piotr@gmail.com>
 <20181107150327.B6DC41124E14@debutante.sirena.org.uk>
 <20181107151836.GB6809@sirena.org.uk>
 <20181108095022.66ad3ad1@bbrezillon>
Message-ID: <20181108120752.GC6675@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 08, 2018 at 09:50:22AM +0100, Boris Brezillon wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > Sorry, I got confused about which patch series Boris had asked me to
> > apply for him - it wasn't this one!  Since the review looked like it was
> > just one minor issue last time I'll just leave them for now, they were
> > applied on a separate branch for sharing with the MTD tree so it's easy
> > for me to drop them if that's required or if I should put together the
> > pull request for MTD.  Sorry for any confusion this ends up causing,
> > it's entirely my mistake.

> I'm probably missing something, but I don't see where you made a
> mistake :-). It's indeed the series I asked you to merge, the only
> comment I had was actually a suggestion to help Piotr solve his perf
> issue (which was already present in the old driver).

Oh, OK.  Then we can definitively say I'm confused then :)

> And thanks for creating the mtd topic branch BTW.

Here's a signed tag for just the MTD bits:

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-mtd-atmel

for you to fetch changes up to 6ca622c87149a20a47abbb954f896f515e2292a7:

  mtd: spi-nor: atmel-quadspi: Remove unused code from atmel-quadspi driver (2018-11-07 13:21:10 +0000)

----------------------------------------------------------------
mtd: Atmel QuadSPI changes for MTD

These changes are dependencies for a branch merged into the SPI tree,
create a signed tag to share them with the MTD tree.

----------------------------------------------------------------
Piotr Bugalski (4):
      mtd: spi-nor: atmel-quaspi: Typo fix
      mtd: spi-nor: atmel-quadspi: Add spi-mem support to atmel-quadspi
      mtd: spi-nor: atmel-quadspi: Use spi-mem interface for atmel-quadspi driver
      mtd: spi-nor: atmel-quadspi: Remove unused code from atmel-quadspi driver

 drivers/mtd/spi-nor/atmel-quadspi.c | 528 ++++++++++--------------------------
 1 file changed, 148 insertions(+), 380 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181108/63bfbf76/attachment.sig>
