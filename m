From: broonie@kernel.org (Mark Brown)
Date: Thu, 29 Jan 2015 11:52:29 +0000
Subject: [RFC] ASoC: rt5677: fix SPI dependency
In-Reply-To: <19778554.1IDiTWklUc@wuerfel>
References: <19778554.1IDiTWklUc@wuerfel>
Message-ID: <20150129115229.GE21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 10:31:30PM +0100, Arnd Bergmann wrote:
> The rt5677 codec has gained code that requires SPI to work correctly,
> but there is no provision in Kconfig to prevent the driver from
> being used when SPI is disabled or a loadable module, resulting
> in this build error:

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150129/993a87a2/attachment-0001.sig>
