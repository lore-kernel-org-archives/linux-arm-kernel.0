From: broonie@kernel.org (Mark Brown)
Date: Mon, 23 Feb 2015 23:21:35 +0900
Subject: [PATCH] drivers: spi: fix compiler warning in spi-s3c64xx
In-Reply-To: <1424694646-26002-1-git-send-email-andre.przywara@arm.com>
References: <1424694646-26002-1-git-send-email-andre.przywara@arm.com>
Message-ID: <20150223142135.GC6236@finisterre.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 23, 2015 at 12:30:46PM +0000, Andre Przywara wrote:
> The Exynos 7 arm64 support now allows the S3C64xx SPI driver to be
> compiled into an ARM64 kernel, so the cast from the [rt]x_dmach int
> variable to a void* in this driver now triggers a warning.
> Add a long cast to silence the compiler.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150223/315b1899/attachment.sig>
