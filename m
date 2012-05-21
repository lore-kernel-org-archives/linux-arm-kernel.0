From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 May 2012 23:45:07 +0200
Subject: [PATCH 15/16] ARM: ux500: Add regulator support for nomadik-i2c
 into the db8500 Device Tree
In-Reply-To: <1337330355-17747-16-git-send-email-lee.jones@linaro.org>
References: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
 <1337330355-17747-16-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdanT17H4VV1AzaYN0wnsFKJTVhw0ZT+o3nP9v=gpKdyAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2012 at 10:39 AM, Lee Jones <lee.jones@linaro.org> wrote:

> Now we have full ab8500 and db8500-prcmu regulator support within DT
> we can easily reference them from within each of the consumer's nodes.
> Here we reference the ones used by each of the Nomadic I2C controllers.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

I'm hesitant about this. It seems to be going about things the wrong way
to have the platform device take a voltage domain regulator.

Yours,
Linus Walleij
