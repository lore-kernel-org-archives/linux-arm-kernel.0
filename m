From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 4 Jul 2014 21:57:26 +0200
Subject: [PATCH 04/12] mfd: stmpe: Rid data size incompatibility warn when
 building for 64bit
In-Reply-To: <1404314924-23564-5-git-send-email-lee.jones@linaro.org>
References: <1404314924-23564-1-git-send-email-lee.jones@linaro.org>
 <1404314924-23564-5-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaDzCDh+UbaF_5no5gQSphoJPnjMKUCXRCxq3BvLo9chg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 2, 2014 at 5:28 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Extinguishes:
>
> ../drivers/mfd/stmpe-i2c.c: In function ?stmpe_i2c_probe?:
> ../drivers/mfd/stmpe-i2c.c:88:13:
>         warning: cast from pointer to integer of different size
>         partnum = (int)of_id->data;
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Not to mention that it uses the enum where the enum is due.
Good patch.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
