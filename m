From: broonie@kernel.org (Mark Brown)
Date: Thu, 19 Feb 2015 18:41:55 +0900
Subject: [PATCH] spi: sirf: add reset controller dependency
In-Reply-To: <4553005.HBquOfbqXe@wuerfel>
References: <4553005.HBquOfbqXe@wuerfel>
Message-ID: <20150219094155.GA3198@finisterre.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 18, 2015 at 04:29:10PM +0100, Arnd Bergmann wrote:

> The adds a dependency in Kconfig to prevent it from being selected
> if the resets are not available.

Why is this a better fix than making the reset controller API stub
itself out?  It's probably not such a big deal here but for devices that
could be integrated into SoCs with and without reset controllers it
seems like we might want that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150219/dd4ffce6/attachment-0001.sig>
