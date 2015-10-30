From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 30 Oct 2015 19:29:26 +0900
Subject: [PATCH 2/2] pinctrl: uniphier: guard uniphier directory with
 CONFIG_PINCTRL_UNIPHIER
In-Reply-To: <CACRpkdZ286dBTvd3EO_GTixnS=Cz-ch-H+AzNOJhZwoB63K6jw@mail.gmail.com>
References: <1445912911-1292-1-git-send-email-yamada.masahiro@socionext.com>
 <1445912911-1292-2-git-send-email-yamada.masahiro@socionext.com>
 <CACRpkdZ286dBTvd3EO_GTixnS=Cz-ch-H+AzNOJhZwoB63K6jw@mail.gmail.com>
Message-ID: <CAK7LNAQsD=kG1X0SXPJ78FLpgEwk023cHEjE8P2UAAPhFATqOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus.

2015-10-29 22:34 GMT+09:00 Linus Walleij <linus.walleij@linaro.org>:
> On Tue, Oct 27, 2015 at 3:28 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>
>> CONFIG_PINCTRL_UNIPHIER is more suitable than CONFIG_ARCH_UNIPHIER
>> to guard the drivers/pinctrl/uniphier directory.
>>
>> The current CONFIG_PINCTRL_UNIPHIER_CORE is a bit long
>> (it would break the indentation in drivers/pinctrl/Makefile),
>> so rename it into CONFIG_PINCTRL_UNIPHIER.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Holding this back until we know what to do with the first patch
> but it looks OK.

I've re-sent this as a single patch
in case 1/2 might take some time for review.


As you agreed with this one, please let it go in first.




-- 
Best Regards
Masahiro Yamada
