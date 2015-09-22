From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 Sep 2015 18:05:18 -0700
Subject: [PATCH v3 5/9] gpiolib: Add gpio name information to
 /sys/kernel/debug/gpio
In-Reply-To: <1439561466-14350-6-git-send-email-mpa@pengutronix.de>
References: <1439561466-14350-1-git-send-email-mpa@pengutronix.de>
 <1439561466-14350-6-git-send-email-mpa@pengutronix.de>
Message-ID: <CACRpkdZDsy+D+BMwjD5dCyi0c3Ha64K4jOJgySh8+6ELNuce2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 14, 2015 at 7:11 AM, Markus Pargmann <mpa@pengutronix.de> wrote:

> Add some information about gpio names to the debugfs gpio file. name and
> label of a GPIO are then displayed next to each other. This way it is
> easy to see what the real name of GPIO is and what the driver requested
> it for.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

PARTLY applied.

> +++ b/Documentation/ABI/testing/sysfs-gpio
> @@ -21,6 +21,7 @@ Description:
>             /value ... always readable, writes fail for input GPIOs
>             /direction ... r/w as: in, out (default low); write: high, low
>             /edge ... r/w as: none, falling, rising, both
> +           /name ... r/o, unique name of the GPIO

This patch has nothing to do with sysfs and this is not added to the ABI.
I removed this hunk from the patch.

The rest is applied.

Yours,
Linus Walleij
