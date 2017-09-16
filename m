From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 17 Sep 2017 00:25:12 +0200
Subject: [PATCH 1/5] i2c: gpio: Convert to use descriptors
In-Reply-To: <20170914093509.uwk47vt3wnm3rtqb@dell>
References: <20170910214424.14945-1-linus.walleij@linaro.org>
 <20170910214424.14945-2-linus.walleij@linaro.org>
 <20170914093509.uwk47vt3wnm3rtqb@dell>
Message-ID: <CACRpkdZYDALXSoEE9jdo7A5P4XZczVbh_uiLkE54=sRtA3rNDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 14, 2017 at 11:35 AM, Lee Jones <lee.jones@linaro.org> wrote:

>>  drivers/mfd/sm501.c                          |  49 +++++-----
>
> I'd prefer for this to be applied with a Tested-by.  I appreciate that
> this is an old driver, but can you attempt to contact one of the
> authors or someone else who might have hardware please?

For SM501 specifically I guess.

OK makes sense as it is the most invasive one, paging around...

Ben, Ville, Magnus, Heiko, Guenther: is one of you still using this
hardware so you can test the patch set?

Yours,
Linus Walleij
