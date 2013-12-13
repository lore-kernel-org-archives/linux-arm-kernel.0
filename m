From: broonie@kernel.org (Mark Brown)
Date: Fri, 13 Dec 2013 10:22:52 +0000
Subject: [PATCH v3 5/6] ARM: pinctrl: Add Broadcom Capri pinctrl driver
In-Reply-To: <CACRpkdaeZCodKv6R+4ZS3o-5u=QQuV3JidEp7uaLsN9aYG7bqA@mail.gmail.com>
References: <1381174108-25168-1-git-send-email-syin@broadcom.com>
 <1386787041-6035-1-git-send-email-syin@broadcom.com>
 <1386787041-6035-6-git-send-email-syin@broadcom.com>
 <CACRpkdaeZCodKv6R+4ZS3o-5u=QQuV3JidEp7uaLsN9aYG7bqA@mail.gmail.com>
Message-ID: <20131213102252.GS11044@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 09:54:50PM +0100, Linus Walleij wrote:

> This is a reimplementation of regmap for MMIO.
> See drivers/base/regmap/regmap-mmio.c
> Notice how regmap_update_bits() is used throughout the
> kernel.

> If you want to do this, use regmap.

Or if this is very performance sensitive (which I'd not expect for
pinctrl) there's a helper in review at the minute which just uses a
spinlock.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131213/52664436/attachment.sig>
