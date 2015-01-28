From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Jan 2015 17:36:47 +0000
Subject: [PATCH] spi/rockchip: avoid uninitialized-use warning
In-Reply-To: <1957186.KORYFIrP42@wuerfel>
References: <1957186.KORYFIrP42@wuerfel>
Message-ID: <20150128173647.GZ21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 02:25:10PM +0100, Arnd Bergmann wrote:
> We currently get a warning about potentially uninitialized variables
> in the rockchip spi driver, at least in certain toolchain versions:

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150128/82d194a8/attachment.sig>
