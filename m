From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Feb 2016 09:15:08 +0100
Subject: [PATCH] ARM: Use generic clkdev.h header
In-Reply-To: <7387260.8XnD1ditcY@wuerfel>
References: <1453932702-6930-1-git-send-email-sboyd@codeaurora.org>
 <6141409.WI4q6BtOxa@wuerfel>
 <20160128201238.GN12841@codeaurora.org>
 <7387260.8XnD1ditcY@wuerfel>
Message-ID: <CACRpkdZj8JM+qYYfE4+cF1iMevJS5t-c_KpV-2jjjspFywf+XQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2016 at 11:07 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 28 January 2016 12:12:38 Stephen Boyd wrote:
>> From: Stephen Boyd <sboyd@codeaurora.org>
>> Subject: [PATCH] ARM: plat-versatile: Remove unused clock.c file
>>
>> This file isn't compiled anymore because PLAT_VERSATILE_CLOCK is
>> never selected. Remove the file and the config.
>>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
>>  arch/arm/plat-versatile/Kconfig  |  3 --
>>  arch/arm/plat-versatile/Makefile |  1 -
>>  arch/arm/plat-versatile/clock.c  | 74 ----------------------------------------
>>  3 files changed, 78 deletions(-)
>>  delete mode 100644 arch/arm/plat-versatile/clock.c
>>
>
> Looks good, I've added it to my todo list for arm-soc in 4.6.
>
> I think Linus Walleij has some related work pending, so I'll
> let him Ack this patch or pick it up in his tree if he prefers.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

OK yeah I have a bunch of Versatile family cleanups pending,
I will put this in the bottom of the pile before the pull request,
thanks!

Yours,
Linus Walleij
