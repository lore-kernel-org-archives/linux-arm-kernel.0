From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 18 Jun 2011 10:55:18 +0200
Subject: [PATCH] plat-iop: fix build error
In-Reply-To: <87ei2sfq8j.fsf@lebrac.rtp-net.org>
References: <1308312232-30488-1-git-send-email-linus.walleij@stericsson.com>
	<87ei2sfq8j.fsf@lebrac.rtp-net.org>
Message-ID: <BANLkTimo=oFQneCG1iQmWMf9xw4wLkGKaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/6/17 Arnaud Patard <arnaud.patard@rtp-net.org>:

>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> The iop13xx_defconfig didn't build since the platform code uses
>> defines from <asm/ptrace.h>. Simply add the include so it
>> compiles.
>
> fwiw, same patch has been sent some time ago
> (http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/052021.html)
> but I don't know if it has been merged.

It hasn't since nobody has submitted it to the ARM maintainer.

I will put my patch into Russells patch tracker so it happens.

Thanks,
Linus Walleij
