From: rabin@rab.in (Rabin Vincent)
Date: Wed, 19 Jan 2011 10:43:10 +0530
Subject: [PATCH] ux500: add a few AB8500 regulator consumers v2
In-Reply-To: <1295390574-8969-1-git-send-email-linus.walleij@stericsson.com>
References: <1295390574-8969-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <AANLkTiki4E9zPKZVNV_LGDkUD=5eajYxrvq=8h3g-GHx@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 19, 2011 at 04:12, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> + ? ? ? /* lsm303dlh magnetometer */
> + ? ? ? REGULATOR_SUPPLY("avdd", "3-001e"),

I don't see an "avdd" in the lsm303dlh datasheet.
http://www.st.com/stonline/books/pdf/docs/16941.pdf

> + ? ? ? /* Synaptics RMI4 Touchscreen device */
> + ? ? ? REGULATOR_SUPPLY("avdd", "3-004b"),
> +};

And neither in the Synaptics datasheet.
