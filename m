From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 22 Jul 2018 08:24:15 +0900
Subject: [GIT PULL 3/3] ARM: uniphier: UniPhier SoC updates for v4.19
In-Reply-To: <20180721212430.odjwcusbbihffo6l@localhost>
References: <CAK7LNAShLhWqCRR8RfuJ0xBJAFoj-S6WLcSdh9QShg8dGfq9RA@mail.gmail.com>
 <20180721212430.odjwcusbbihffo6l@localhost>
Message-ID: <CAK7LNAQHL16vxv7twzy9PPkLLrbvzuAMa9QtOjSN3Z1KHWKG_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

2018-07-22 6:24 GMT+09:00 Olof Johansson <olof@lixom.net>:
> On Thu, Jul 19, 2018 at 08:05:03AM +0900, Masahiro Yamada wrote:
>> Hi Arnd, Olof,
>>
>> Please pull UniPhier SoC changes for the v4.19 MW.
>>
>> Thanks!
>>
>>
>> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
>>
>>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
>> tags/uniphier-soc-v4.19
>>
>> for you to fetch changes up to ae93e694440a454609fa40725e16619c5a781768:
>>
>>   ARM: uniphier: remove empty Makefile (2018-07-19 06:53:16 +0900)
>>
>> ----------------------------------------------------------------
>> UniPhier ARM SoC updates for v4.19
>>
>> - enable ethernet and thermal drivers from multi_v7_defconfig
>>
>> - select RESET_CONTROLLER
>>
>> - remove empty arch/arm/mach-uniphier/Makefile
>>
>> ----------------------------------------------------------------
>> Kunihiko Hayashi (1):
>>       ARM: multi_v7_defconfig: add CONFIG_UNIPHIER_THERMAL and CONFIG_SNI_AVE
>
> I renormalied multi_v7_defconfig for 4.18-rc3, so please base your branch
> on that to avoid conflicts.
>
> Also, we separate out defconfig updates to branches on their own. I can
> cherry-pick the branch apart but wanted to check with you before I do
> so in case it messes up your workflow. If it does, send a fresh pull
> request for SoC, and either one for the defconfig or just the patch and
> we can apply it directly.
>

Can you do cherry-pick please?

Thanks!





-- 
Best Regards
Masahiro Yamada
