From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 2 Oct 2011 23:27:59 +0200
Subject: [PATCH v2 0/5] ARM: pxa: move gpio driver into drivers directory
In-Reply-To: <20111001165105.GM11710@n2100.arm.linux.org.uk>
References: <1317377960-11063-1-git-send-email-haojian.zhuang@marvell.com>
	<20111001164241.GK11710@n2100.arm.linux.org.uk>
	<20111001165105.GM11710@n2100.arm.linux.org.uk>
Message-ID: <CAKnu2Mq=R9DSQsp9OUGEFFzXc8hs=HG4jSmTC5qYderhtBV-8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/1 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Sat, Oct 01, 2011 at 05:42:41PM +0100, Russell King - ARM Linux wrote:
>> On Fri, Sep 30, 2011 at 06:19:15PM +0800, Haojian Zhuang wrote:
>> > Changelog:
>> > v2:
>> > ? ? 1. Remove gpio.c from mach-pxa & mach-mmp that is introduced from v1.
>> > ? ? 2. Remove init function in gpio.c. Move the platfrom_device_register()
>> > ? ? ? ?into platform driver.
>> > ? ? 3. Initialize pxa_gpio_regs in gpio-pxa.c
>> > ? ? 4. Simplify code of identifing pxa gpio series or mmp gpio series.
>> > ? ? 5. Use linux/io.h instead of asm/io.h.
>>
>> This series looks fine to me. ?You don't mention what it's based upon -
>> should I assume my gpio patch series? ?If so, it looks fine to be
>> submitted to the patch system.
>>
>> It would be nice to have a few acks from people against it first though.
>
> I assume this clashes with patches 7103/1 and 7104/1 in the patch system.
> Should I ignore those two for the meantime?

This series includes the stuff in those patches so if these are cleared
feel free to drop 7103/1 + 7104/1 and apply these instead, they do
the same thing and some more.

Yours,
Linus Walleij
