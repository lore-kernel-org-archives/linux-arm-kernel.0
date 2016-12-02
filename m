From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 2 Dec 2016 13:39:15 +0100
Subject: [PATCH] ARM/ARM64: defconfig: drop GPIO_SYSFS on multiplatforms
In-Reply-To: <5151997.6RlLpvHqsO@wuerfel>
References: <1479999472-2664-1-git-send-email-linus.walleij@linaro.org>
 <5151997.6RlLpvHqsO@wuerfel>
Message-ID: <CACRpkdZkLFioSH-7rZ6w3wa29_GoV9BYpXUFisuOJG-vP4bQMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2016 at 11:04 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday, November 24, 2016 3:57:52 PM CET Linus Walleij wrote:
>> The sysfs ABI to GPIO is marked obsolete and should not be
>> encouraged. Users should be encouraged to switch to using the
>> character device.
(...)
>>  arch/arm/configs/multi_v5_defconfig | 1 -
>>  arch/arm/configs/multi_v7_defconfig | 1 -
>>  arch/arm64/configs/defconfig        | 1 -
>
> Hmm, while this is a trivial change, we normally put the defconfig
> changes for arm and arm64 into two separate next/* branches.
>
> I've split the patch up accordingly and slightly modified the
> changelog text to match.

OK thanks a lot Arnd, I was a bit uncertain about that.

Yours,
Linus Walleij
