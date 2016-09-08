From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 8 Sep 2016 12:00:23 +0200
Subject: [PATCH 2/2] ARM: dts: add device tree for the RealView EB Rev D
In-Reply-To: <15288435.aYlmo6e5Gb@wuerfel>
References: <1473327043-31903-1-git-send-email-linus.walleij@linaro.org>
 <15288435.aYlmo6e5Gb@wuerfel>
Message-ID: <CACRpkdZdY-knG+htdgZ0t80GLqC7aNujNf7mwUveDrAnCQ5yfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 8, 2016 at 11:44 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday, September 8, 2016 11:30:43 AM CEST Linus Walleij wrote:
>> @@ -608,6 +608,7 @@ dtb-$(CONFIG_ARCH_REALVIEW) += \
>>         arm-realview-pb1176.dtb \
>>         arm-realview-pb11mp.dtb \
>>         arm-realview-eb.dtb \
>> +       arm-realview-eb-revd.dtb \
>>         arm-realview-eb-11mp.dtb \
>>         arm-realview-eb-11mp-revb.dtb \
>>         arm-realview-eb-a9mp.dtb \
>
> Is the ethernet device on the baseboard or the core tile?

It's on the baseboard.

> My understanding is that you have a baseboard which comes in
> different revisions and a set of CPU modules (arm9, arm1136,
> arm1176, arm11mp, cortex-a9, ...) that can be freely combined,
> so if the ethernet device is on the baseboard, we also need revd
> variants for 11mp and a9mp.

Yeah... you're right.

> The arm-realview-eb-11mp-revb seems to refer to RevB of
> the core tile rather than the baseboard (?), so we may need
> a better notation for the file names to clarify that difference.

OK will try to come up with some namespace.

Revisiting this mess...

Yours,
Linus Walleij
