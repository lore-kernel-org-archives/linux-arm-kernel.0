From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Wed, 3 Sep 2014 13:11:43 +0530
Subject: [PATCH 06/14] pinctrl: samsung: use CONFIG_PINCTRL_SAMSUNG symbol
 in makefile
In-Reply-To: <CACRpkda=LCT_P7czZ6mNX_7eS9nyKwxZrzXO2AAQ8W5RrehCcw@mail.gmail.com>
References: <1409132889-2080-1-git-send-email-ch.naveen@samsung.com>
 <1409132889-2080-6-git-send-email-ch.naveen@samsung.com>
 <CACRpkda=LCT_P7czZ6mNX_7eS9nyKwxZrzXO2AAQ8W5RrehCcw@mail.gmail.com>
Message-ID: <CAHfPSqCND6QsuxiJjy7+jUb2PV3AVb=OtsGE=FL_mN5jJm6q0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 August 2014 18:07, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Aug 27, 2014 at 11:48 AM, Naveen Krishna Chatradhi
> <ch.naveen@samsung.com> wrote:
>
>> Samsung Exynos7 is a ARM64bit processor. Which does not select
>> the CONFIG_PLAT_SAMSUNG symbol. CONFIG_PINCTRL_SAMSUNG is being
>> selected for both PLAT_SAMSUNG and ARCH_EXYNOS7 symbols.
>>
>> This patch modifes the pinctrl/Makefile to use
>> CONFIG_PINCTRL_SAMSUNG symbol to compile the pinctrl/samsung/*.c
>>
>> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
>> Cc: Tomasz Figa <t.figa@samsung.com>
>> Cc: linus.walleij at linaro.org
>> Cc: Thomas Abraham <thomas.ab@samsung.com>
>
> Excellent catch, thanks, patch applied!

Thanks Linus.

>
> I should use this pattern on more places in the Makefile,
> I was confused by logically thinking that Kconfig symbols
> used in Makefile cannot be from a Kconfig one level below.
>
> Yours,
> Linus Walleij


-- 
Shine bright,
(: Nav :)
