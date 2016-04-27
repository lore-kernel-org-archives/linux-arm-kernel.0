From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Wed, 27 Apr 2016 13:58:10 -0300
Subject: [PATCH] ARM: Drop CONFIG_RTC_LIB dependency
In-Reply-To: <7827332.ilWiE07kMM@wuerfel>
References: <1459569633-6470-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <4624574.xXAYWxU134@wuerfel>
 <CAAEAJfC3zJiVv9bCmP1VqpHkMPNbaqx75mmsXEh7k7UMU6DGVQ@mail.gmail.com>
 <7827332.ilWiE07kMM@wuerfel>
Message-ID: <CAAEAJfBSi=1HK4ZD7BpTxW53sZ5aFLEnxzeTQUOvc9c5APLCUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 April 2016 at 17:34, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 15 April 2016 16:22:18 Ezequiel Garcia wrote:
>> > Sorry for missing this the first time around. The patch looks fine to me,
>> > but I wonder if we should just do this for all architectures, the patch
>> > below looks like it should do the trick. If you want to have your ARM
>> > patch merged separately, that's fine too, please add my
>> >
>> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>> >
>>
>> Sure, if your patch does not break any platform, then
>> I think it's much better than taking mine.
>
> I've gone through my patches again to see which ones to submit and
> it turned out that mine was wrong: we can't remove the symbol
> because some architectures (not ARM) symbols exported by
> drivers/rtc/rtc-lib.c.
>

Yeah, that was my impression, but I wasn't sure about it.
Thanks for confirming it.

> Your patch is fine, and we can do the same thing on arm64.
>

OK, I just sent a patch for arm64 and I'll be pushing this one to
Russell's tracker.
-- 
Ezequiel Garc?a, VanguardiaSur
www.vanguardiasur.com.ar
