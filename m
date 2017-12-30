From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 31 Dec 2017 00:10:33 +0100
Subject: [PATCH v2] i2c/ARM: davinci: Deep refactoring of I2C recovery
In-Reply-To: <20171220121749.12064-1-linus.walleij@linaro.org>
References: <20171220121749.12064-1-linus.walleij@linaro.org>
Message-ID: <20171230231033.agmapevszacyqje5@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 20, 2017 at 01:17:49PM +0100, Linus Walleij wrote:
> Alter the DaVinci GPIO recovery fetch to use descriptors
> all the way down into the board files.
> 
> Cc: arm at kernel.org
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Acked-by: Sekhar Nori <nsekhar@ti.com>
> Tested-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171231/bf397465/attachment.sig>
