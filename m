From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 Aug 2012 10:24:28 -0700
Subject: [PATCH] clk: convert ARM RealView to common clk
In-Reply-To: <1346330027.2623.4.camel@hornet>
References: <1344270728-7550-1-git-send-email-linus.walleij@stericsson.com>
 <1346330027.2623.4.camel@hornet>
Message-ID: <CACRpkdbEU6zWd6-SK+pAxSUd8Vow+3JP5ZkxdijZwYraekEW8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2012 at 5:33 AM, Pawel Moll <pawel.moll@arm.com> wrote:
[Me]
>> +config COMMON_CLK_VERSATILE
>> +       tristate "Clock driver for ARM Reference designs"
>
> It can't really be a "tristate", can it? To my mind there is no way of
> making it a module, so a "bool" seems more appropriate?

You're right, I'll send a small fixup patch to Mike.

Yours,
Linus Walleij
