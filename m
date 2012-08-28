From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 Aug 2012 17:13:39 -0700
Subject: [PATCH 0/3] Removal of obsolete s3c2410_* GPIO API
In-Reply-To: <1345897243-15619-1-git-send-email-sylvester.nawrocki@gmail.com>
References: <1345897243-15619-1-git-send-email-sylvester.nawrocki@gmail.com>
Message-ID: <CACRpkdaspHBDUjwf_bPtZoFeYK7q97oX4Jat=pmX810RtGJOpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 25, 2012 at 5:20 AM, Sylwester Nawrocki
<sylvester.nawrocki@gmail.com> wrote:

> This short patch series converts remaining users of the s3c24xx SoC
> specific gpiolib functions to the gpiolib API and finally removes
> all s3c2410_* functions from drivers/gpio/gpio-samsung.c.

I'm fine with this as long as the Samsung maintainer is, so
Acked-by: Linus Walleij <linus.walleij@linaro.org>

But I suspect this will be merged through the Samsung SoC tree?

Yours,
Linus Walleij
