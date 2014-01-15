From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 Jan 2014 13:51:09 +0100
Subject: [PATCH] ARM: S3C[24|64]xx: move includes back under <mach/> scope
In-Reply-To: <6144980.CZru2D3yJB@wuerfel>
References: <1389707618-17011-1-git-send-email-linus.walleij@linaro.org>
 <CAHbNUh29qGSt-isqOAdVVO3x0w2mDTVnKeH+Sc_rkfkOiXc_mA@mail.gmail.com>
 <6144980.CZru2D3yJB@wuerfel>
Message-ID: <CACRpkdbTdAS_iGOrVmsCZ_ggYMuk13LkE3oJ-YzHT3cUB+m5Lg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 15, 2014 at 10:43 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 15 January 2014 14:41:01 Tushar Behera wrote:
>>
>> This inclusion should be protected by a check for CONFIG_ARCH_S3C24XX
>> || CONFIG_ARCH_S3C64XX. Currently generating build errors for
>> s5p64x0_defconfig, s5pc100_defconfig and s5pv210_defconfig on
>> next-20140115.
>
> I noticed the same problem, but I think a better solution would
> be to do the same change for s5p that Linus has done for s3c,
> which is to move the nonstandard contents of mach/gpio.h to
> mach/gpio-samsung.h.

Hm I just applied a fixup from Sachin adding #ifdefs back in
but maybe I should try to fix it up like that instead. Just a minute...

Yours,
Linus Walleij
