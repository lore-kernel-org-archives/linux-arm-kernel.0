From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 25 Apr 2018 00:44:45 +0900
Subject: [PATCH] arm64: dts: uniphier: fix input delay value for legacy
 mode of eMMC
In-Reply-To: <CAK7LNAShZOxANg1T=9eGgN1MYRVP3qC1n6i8QO07CChPuge-aA@mail.gmail.com>
References: <1523500291-24008-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNAShZOxANg1T=9eGgN1MYRVP3qC1n6i8QO07CChPuge-aA@mail.gmail.com>
Message-ID: <CAK7LNARyMHSq-sCiJJem3twr-5YeGq4eyZqYXN+n5G1JUfzUfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-04-12 13:45 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> 2018-04-12 11:31 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>> The property of the legacy mode for the eMMC PHY turned out to
>> be worng.  Some eMMC devices are unstable due to the set-up/hold
>> timing violation.  Correct the delay value.
>
> Reminder for myself:
>   Fix a type  worng -> wrong
>

Applied to linux-uniphier.


-- 
Best Regards
Masahiro Yamada
