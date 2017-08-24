From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 24 Aug 2017 22:34:56 +0200
Subject: [PATCH 08/11] watchdog: ftwdt010/moxart: Merge MOXA ART into
 FTWDT010
In-Reply-To: <20170814160932.GD7025@roeck-us.net>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
 <20170812184318.10144-9-linus.walleij@linaro.org>
 <20170814160932.GD7025@roeck-us.net>
Message-ID: <CACRpkdaNkzWYwksEaMdNKvRo_eimSvPaZhjfwgDLgGQt38mjSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 6:09 PM, Guenter Roeck <linux@roeck-us.net> wrote:

>>       default ARCH_GEMINI
>> +     default ARCH_MOXART
>
> Can one have more than one default statement ? What is the semantics ?
> Just making sure that it isn't "last one wins".

I would guess logical OR but to be on the safe side, I will
convert these to an explicit default (ARCH_GEMINI || ARCH_MOXART)

Yours,
Linus Walleij
