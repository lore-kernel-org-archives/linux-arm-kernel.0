From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 10 Nov 2017 16:01:38 +0100
Subject: [PATCH v2] ARM: sa1100: simpad: Correct I2C GPIO offsets
In-Reply-To: <20171110145038.i4jnqsctdzkfmoe5@ninjato>
References: <20171107201857.5752-1-linus.walleij@linaro.org>
 <20171110145038.i4jnqsctdzkfmoe5@ninjato>
Message-ID: <CACRpkdangY192aFpSd1hVaie6A8kY+sASORhR_ncHLYLeUJMWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 10, 2017 at 3:50 PM, Wolfram Sang <wsa@the-dreams.de> wrote:

> Applied to for-next, thanks!

Thanks man.

> This from checkpatch makes sense to me:
>
> ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit b2e63555592f ("i2c: gpio: Convert to use descriptors")'
> #21:
> commit b2e63555592f81331c8da3afaa607d8cf83e8138

I never understood that thingie, I thought the check was
only there in order to stop Fixes: tags from running wild.
But feel free to cut it if you want.

Yours,
Linus Walleij
