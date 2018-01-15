From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 15 Jan 2018 19:03:03 +0100
Subject: i2c: Include GPIO consumer header in main include
In-Reply-To: <20171208133934.18038-1-linus.walleij@linaro.org>
References: <20171208133934.18038-1-linus.walleij@linaro.org>
Message-ID: <20180115180303.pdax5amdj2rtytih@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 08, 2017 at 02:39:34PM +0100, Linus Walleij wrote:
> It seems most users of <linux/i2c.h> pick up their
> dependency of <linux/gpio/consumer.h> from other paths but
> that is not a universal law, so include the header
> explicitly so we have struct gpio_desc available.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

I still think drivers needing GPIO should include it explicitly.
So, NAK until further arguments arrive...

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180115/11fd1e6e/attachment.sig>
