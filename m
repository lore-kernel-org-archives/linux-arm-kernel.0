From: broonie@kernel.org (Mark Brown)
Date: Thu, 27 Sep 2018 23:04:39 +0100
Subject: [PATCH] ARM: Assume maintainership of ARM reference designs
In-Reply-To: <20180927073733.11580-1-linus.walleij@linaro.org>
References: <20180927073733.11580-1-linus.walleij@linaro.org>
Message-ID: <20180927220439.GB20825@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2018 at 09:37:33AM +0200, Linus Walleij wrote:

> +F:	drivers/spi/spi-pl022.c

The pl022 is actively used by *way* more than just the Arm reference
platforms, it's a really popular IP though the driver is fairly feature
complete at this point.  I'd like to at least see this split out as a
separate thing rather than lumped in so that people don't discount the
get_maintainers match as a false positive, though I'm totally fine with
you taking it over.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180927/0dfb0498/attachment.sig>
