From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 12 Jul 2016 15:57:29 +0200
Subject: [stericsson:sensors 5/5]
 drivers/iio/magnetometer/ak8974.c:502:2-8:
 preceding lock on line 498 (fwd)
In-Reply-To: <alpine.DEB.2.10.1607121239170.3034@hadrien>
References: <alpine.DEB.2.10.1607121239170.3034@hadrien>
Message-ID: <CACRpkdZxJc7xuajDHv+Qg5KjOZK=8_-9Rvhns=LwV7wzvMH1KA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2016 at 12:39 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:

> Looks suspicious, please check.
>
> julia

Thanks Julia, very good hint. The locking was a mess and it was
all my fault :(

I've fixed it up now.

Yours,
Linus Walleij
