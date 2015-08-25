From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 25 Aug 2015 10:50:00 +0900
Subject: [PATCH 0/3] ARM: uniphier: add outer cache support and rework SMP
 operations
In-Reply-To: <CAOesGMgL3bNH_wG3igSJhNOkV0uUfNWEi0t-Gny2A1oNnGKu=w@mail.gmail.com>
References: <1440382692-3855-1-git-send-email-yamada.masahiro@socionext.com>
 <CAOesGMgL3bNH_wG3igSJhNOkV0uUfNWEi0t-Gny2A1oNnGKu=w@mail.gmail.com>
Message-ID: <CAK7LNAQk4aEgZV3y90zBVMeq=jA45v683sCR1e5BBYtg5AcDOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,


2015-08-25 6:47 GMT+09:00 Olof Johansson <olof@lixom.net>:
> Hi,
>
> On Sun, Aug 23, 2015 at 7:18 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> 1/3: add outer cache support
>> 2/3: rework SMP operations
>> 3/3: add device tree nodes
>
> Timing of this is unfortunate, please resend after 4.3-rc1 is out and
> we can queue it up.

Given that rc8 is out and the merge window has been delayed,
is it still too late for 4.3-rc1?



>> Because 2/3 highly depends on 1/3, I hope whole of this series
>> is applied to ARM-SOC tree.
>
> Review or acked-by from Russell would be appreciated in that case.
>
>> Olof,
>> From this series, I am using "ARM: uniphier:" rather than "ARM: UniPhier:"
>> for the subject prefixes because I noticed you often rephased so when you
>> applied my patches.
>> Are sub-arch names in lower cases preferable in subject prefixes?
>
> If you look at "git log --no-merges --oneline arch/arm/mach-*" you'll
> see that most platforms use either all-caps or all-lowercase.

I see.

But, we use "UniPhier" (with only U and P capitalized) in our official
documents.



-- 
Best Regards
Masahiro Yamada
