From: florian@openwrt.org (Florian Fainelli)
Date: Thu, 24 Oct 2013 09:47:24 -0700
Subject: [OpenWrt-Devel] [PATCH] RFT: ARM: gemini: convert to
 GENERIC_CLOCKEVENTS
In-Reply-To: <CACRpkdb6pC-7vWdAHkV3RK6mN8GXTiRQcQBPojk_kgm9JREJAQ@mail.gmail.com>
References: <1380625040-25912-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdbymhLhHObL+fdWCHKbNG_LtudvhXbdxC0NCJApUBjT9w@mail.gmail.com>
 <CACRpkdb6pC-7vWdAHkV3RK6mN8GXTiRQcQBPojk_kgm9JREJAQ@mail.gmail.com>
Message-ID: <CAGVrzcbyODYSVBAbOSr_sT2LAp7pO9pb+C8GnrOs61ni67GQsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Linus,

2013/10/24 Linus Walleij <linus.walleij@linaro.org>:
> Adding openwrt-devel to this thread to get some traction...

I won't have my gemini device available for the next 6-8 weeks, so
just go ahead and merge this, if it breaks, there is still time to
figure out how to unbreak later. It cannot possibly be worse since few
people have it and actually seem to use it. Does that work for you?

>
> On Thu, Oct 24, 2013 at 12:06 PM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
>> On Tue, Oct 1, 2013 at 12:57 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>>> This converts the gemini machine to use generic clockevents
>>> by rewriting the timer driver.
>>>
>>> Cc: arm at kernel.org
>>> Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>> ---
>>> This is flagged as Request for Testing (RFT) as I have no Gemini
>>> platform. If I do not get help with testing this, the next step
>>> will be a patch series to delete the platform.
>>
>> OK nobody is able to test this it seems, but it is a vital refactoring.
>>
>> Should we just apply this and see what happens?
>>
>> Or should I just send a deletion patch right away?
>>
>> I would lean toward just applying it and see if the OpenWRT
>> people will notice and/or complain.
>>
>> What does the ARM SoC people say?
>>
>> Yours,
>> Linus Walleij
> _______________________________________________
> openwrt-devel mailing list
> openwrt-devel at lists.openwrt.org
> https://lists.openwrt.org/cgi-bin/mailman/listinfo/openwrt-devel

-- 
Florian
