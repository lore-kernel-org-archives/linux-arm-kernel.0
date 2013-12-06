From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 6 Dec 2013 12:58:21 +0100
Subject: [PATCH] ARM: s3c24xx: get rid of custom <mach/gpio.h>
In-Reply-To: <1386322280-23756-1-git-send-email-linus.walleij@linaro.org>
References: <1386322280-23756-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdZuk3zzhDnj3wJg1cmuqX0Cj-qQ--sBzEEV_XWyeDje3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 6, 2013 at 10:31 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

> This isolates the custom S3C24xx GPIO definition table to
> <linux/platform_data/gpio-samsung-s3x24xx.h>

Maybe I'm too trigger happy. I'll send a combined series with
S3C24xx, S3C64xx and maybe also S5P variants all fixed
so you can see the overall idea here. Hold on.

Yours,
Linus Walleij
