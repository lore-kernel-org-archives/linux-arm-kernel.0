From: broonie@kernel.org (Mark Brown)
Date: Wed, 26 Nov 2014 19:01:37 +0000
Subject: [PATCH] spi: s3c64xx: add support for exynos7 SPI controller
In-Reply-To: <1415267509-16653-1-git-send-email-padma.v@samsung.com>
References: <1415267509-16653-1-git-send-email-padma.v@samsung.com>
Message-ID: <20141126190137.GR7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 06, 2014 at 03:21:49PM +0530, Padmavathi Venna wrote:
> Exynos7 SPI controller supports only the auto Selection of
> CS toggle mode and Exynos7 SoC includes six SPI controllers.
> Add support for these changes in Exynos7 SPI controller driver.

Applied, thanks.  It does seem like these controllers are getting more
restricted in functionality which seems a bit of a shame.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141126/5edae93c/attachment.sig>
