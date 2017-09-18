From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 18 Sep 2017 21:09:39 +0200
Subject: [PATCH 7/7] i2c: gpio: Add support for named gpios in DT
In-Reply-To: <CAMuHMdX+bx9pNEAFoBzfM7JhhH800u-HumpQYRsG3d5BNuduvg@mail.gmail.com>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
 <20170917093906.16325-8-linus.walleij@linaro.org>
 <CAMuHMdX+bx9pNEAFoBzfM7JhhH800u-HumpQYRsG3d5BNuduvg@mail.gmail.com>
Message-ID: <CACRpkdaYjQC9wTCvAJ-zEdX9fvBTRK5sazCd4L32zG3WkB1q4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 18, 2017 at 11:58 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:

>> +       if (ret != -EPROBE_DEFER)
>> +               dev_err(dev, "error trying to get descriptor: %ld\n", ret);
>
> warning: format '%ld' expects argument of type 'long int', but
> argument 3 has type 'int' [-Wformat=]
>
> %d (0day busy?)

Bah haven't pushed it to the 0day builders yet.
I'll do that tonight so I can drown in the build errors.
:-D

Fixing it.

Yours,
Linus Walleij
