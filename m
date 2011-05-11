From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 May 2011 02:17:11 +0200
Subject: [PATCH 2/4] pinmux: add a driver for the U300 pinmux
In-Reply-To: <1304365233.7792.42.camel@Joe-Laptop>
References: <1304363798-30409-1-git-send-email-linus.walleij@stericsson.com>
	<1304365233.7792.42.camel@Joe-Laptop>
Message-ID: <BANLkTinnPWu9TZ72xdnXayrG0QYF+0mMBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/2 Joe Perches <joe@perches.com>:
> On Mon, 2011-05-02 at 21:16 +0200, Linus Walleij wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
> []
>> diff --git a/drivers/pinmux/pinmux-u300.c b/drivers/pinmux/pinmux-u300.c
>> +++ b/drivers/pinmux/pinmux-u300.c
>> +struct u300_pin_desc {
>> + ? ? unsigned number;
>> + ? ? char *name;
>
> const char *name?

Thanks, fixed!

Can I have your reviewed-by for this patch given I fixed that?

Linus Walleij
