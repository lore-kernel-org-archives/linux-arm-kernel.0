From: broonie@kernel.org (Mark Brown)
Date: Sun, 13 Dec 2015 23:08:37 +0000
Subject: [PATCH v3] spi: dts: sun4i: Add support for hardware-based wait
 time between words
In-Reply-To: <1450047853-9005-1-git-send-email-mweseloh42@gmail.com>
References: <1449873940-10167-1-git-send-email-mweseloh42@gmail.com>
 <1450047853-9005-1-git-send-email-mweseloh42@gmail.com>
Message-ID: <20151213230837.GT5727@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 12:04:11AM +0100, Marcus Weseloh wrote:
> Adds a new property "spi-word-wait-ns" to the spi-bus binding that allows

Please don't bury patches in reply to existing serieses, it makes it
hard to follow what's going on with regard to which versions are current
and so on.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151213/0a8d01b2/attachment.sig>
