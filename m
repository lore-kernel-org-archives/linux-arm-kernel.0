From: broonie@kernel.org (Mark Brown)
Date: Sun, 22 Mar 2015 18:01:10 +0000
Subject: [PATCH 09/13] spi: atmel: use endian agnostic IO
In-Reply-To: <1426693992-31163-10-git-send-email-ben.dooks@codethink.co.uk>
References: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
 <1426693992-31163-10-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20150322180110.GN6643@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 03:53:08PM +0000, Ben Dooks wrote:
> Use the endian agnositc IO functions instead of the __raw ones for when
> the driver is in use on big-endian systems.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> --
> CC: Nicolas Ferre <nicolas.ferre@atmel.com> (supporter:ATMEL SPI DRIVER)
> CC: Mark Brown <broonie@kernel.org> (maintainer:SPI SUBSYSTEM)
> CC: linux-spi at vger.kernel.org (open list:SPI SUBSYSTEM)

Applied, thanks.  If you don't want things to go into the message then
they should be after --- not --.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150322/af2032f7/attachment-0001.sig>
