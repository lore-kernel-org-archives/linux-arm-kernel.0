From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 18 Dec 2015 17:24:28 +0100
Subject: [PATCH] ARM: realview: select apropriate targets in defconfig
In-Reply-To: <3702930.VaLXyyDAE1@wuerfel>
References: <1450444794-18478-1-git-send-email-linus.walleij@linaro.org>
 <3702930.VaLXyyDAE1@wuerfel>
Message-ID: <CACRpkdazz9W+yOZWwhKDACmKz8Mh9Wg_B5mAH3ksFMhcXGVNvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 2:28 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 18 December 2015 14:19:54 Linus Walleij wrote:
>> After adding multiplatform support for the RealView, we need
>> to add the apropriate targets to the defconfig so we get the
>> full range of supported devices. This amends both the defconfig
>> files for this.
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>
>
> Looks good to me. Should we also add PBX to multi_v7_defconfig?

Sure, I just haven't tested that. I just wanted to make sure we had
no regressions at this point :)

I will send a separate patch when I have made a boot test for it.

Yours,
Linus Walleij
