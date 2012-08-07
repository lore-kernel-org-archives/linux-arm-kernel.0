From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 7 Aug 2012 11:47:38 +0200
Subject: [PATCH 1/1 v2] i2c: Add default configuration into the Nomadik
 I2C driver.
In-Reply-To: <20120806153503.GH10524@gmail.com>
References: <1344266253-14050-1-git-send-email-lee.jones@linaro.org>
 <20120806153503.GH10524@gmail.com>
Message-ID: <CACRpkdZjbyQbht+UpXrrVGhAzGYPjb=HRZhJ+TvsEXhGeviJLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 6, 2012 at 5:35 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Looks like I introduced a merge error on the last patch. Trying again:

>  .../mali/mali400ko/driver/src/devicedrv/mali/arch  |    1 +
(...)
> diff --git a/drivers/gpu/mali/mali400ko/driver/src/devicedrv/mali/arch b/drivers/gpu/mali/mali400ko/driver/src/devicedrv/mali/arch
> new file mode 120000
> index 0000000..427334b
> --- /dev/null
> +++ b/drivers/gpu/mali/mali400ko/driver/src/devicedrv/mali/arch
> @@ -0,0 +1 @@
> +/home/ljkenny/projects/linaro/snowball/snowball/drivers/gpu/mali/mali400ko/driver/src/devicedrv/mali/arch-ux500
> \ No newline at end of file

NACK, what is this stuff? It's even out-of-tree code.

Please be careful with git add -A, I prefer to use git add <pathspec>
I suspect that may be why this happened...

Please fix it up and send a v3.

Yours,
Linus Walleij
