From: broonie@kernel.org (Mark Brown)
Date: Thu, 6 Nov 2014 10:26:36 +0000
Subject: [PATCH] spi: s3c64xx: add support for exynos7 SPI controller
In-Reply-To: <1415267509-16653-1-git-send-email-padma.v@samsung.com>
References: <1415267509-16653-1-git-send-email-padma.v@samsung.com>
Message-ID: <20141106102636.GT8509@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 06, 2014 at 03:21:49PM +0530, Padmavathi Venna wrote:
> Exynos7 SPI controller supports only the auto Selection of
> CS toggle mode and Exynos7 SoC includes six SPI controllers.
> Add support for these changes in Exynos7 SPI controller driver.

Could you give a bit more detail on what the "auto selection of CS
toggle mode" is - in the diff it looks like it's not an existing mode.
I'm a bit worried that it's not going to function well with devices that
send more than one transfer per message.

> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>

It's better if your signoff is using the same e-maill address as 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141106/c9b3884b/attachment.sig>
