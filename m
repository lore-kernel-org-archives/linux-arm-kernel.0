From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 May 2014 15:59:13 +0200
Subject: [PATCH] gpio: pch: include linux/slab.h
In-Reply-To: <8665687.jWqf6bo4lM@wuerfel>
References: <8665687.jWqf6bo4lM@wuerfel>
Message-ID: <CACRpkdZH92Ps=9-zp-Xg_akq+=q2zGiiGaKzkAu16WqD24XF7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 26, 2014 at 5:04 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The gpio-pch driver was recently enabled for compile-tests,
> which revealed that it is missing an include for linux/slab.h,
> which on ARM is not implied by any of the other headers.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Oh I fixed that up as I was going over the failed build logs.

Sorry that I didn't see this first, thanks anyway!

Yours,
Linus Walleij
