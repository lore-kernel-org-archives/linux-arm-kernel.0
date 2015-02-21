From: broonie@kernel.org (Mark Brown)
Date: Sat, 21 Feb 2015 18:36:11 +0900
Subject: [PATCH v2] ASoC: Samsung: add missing I2C/SPI dependencies
In-Reply-To: <8075847.dUio9f5hRh@wuerfel>
References: <8075847.dUio9f5hRh@wuerfel>
Message-ID: <20150221093611.GJ6236@finisterre.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 18, 2015 at 09:35:08PM +0100, Arnd Bergmann wrote:
> A few sound drivers for the samsung platforms are missing dependencies
> on I2C or SPI, which can lead to build errors like

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150221/13c9ecae/attachment.sig>
