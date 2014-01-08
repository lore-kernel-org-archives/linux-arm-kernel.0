From: broonie@kernel.org (Mark Brown)
Date: Wed, 8 Jan 2014 17:08:08 +0000
Subject: [PATCH 1/2 v3] ARM: s3c24xx: get rid of custom <mach/gpio.h>
In-Reply-To: <CACRpkdacaskiv2R5YTB_9jFaOueXGEFxYQUEo4eq7aHkDLhjfw@mail.gmail.com>
References: <1386939220-12776-1-git-send-email-linus.walleij@linaro.org>
 <201401071215.06064.arnd@arndb.de>
 <CACRpkdacaskiv2R5YTB_9jFaOueXGEFxYQUEo4eq7aHkDLhjfw@mail.gmail.com>
Message-ID: <20140108170808.GH31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 07:27:49PM +0100, Linus Walleij wrote:

> I think the S3C driver is a different piece of hardware unfortunately.

It's not, the IP is basically the same - the difference between s3c, s5p
and Exynos is a marketing one, Samsung have generally just reused IP
where that is reasonable.  There's a great deal of continuity in the
platforms.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140108/4a8abf37/attachment.sig>
