From: broonie@kernel.org (Mark Brown)
Date: Sun, 28 Sep 2014 12:43:53 +0100
Subject: [PATCH] ARM: mvebu: use improved armada spi device tree
 compatible name
In-Reply-To: <20140909160043.GP30828@titan.lakedaemon.net>
References: <1410147029-30067-1-git-send-email-gerg@uclinux.org>
 <20140909160043.GP30828@titan.lakedaemon.net>
Message-ID: <20140928114353.GY27755@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 09, 2014 at 12:00:43PM -0400, Jason Cooper wrote:
> On Mon, Sep 08, 2014 at 01:30:29PM +1000, gerg at uclinux.org wrote:

> > Switch the Armada SoC SPI port device tree binding to use the new improved
> > armada-370-spi compatible name. This allows for a wider range of baud rates
> > to be used.

> Applied to mvebu/dt.

Note that the corresponding driver change hasn't been applied (or sent
to me for review) so this will break users.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140928/7b164e11/attachment.sig>
