From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 12 Apr 2018 13:45:54 +0900
Subject: [PATCH] arm64: dts: uniphier: fix input delay value for legacy
 mode of eMMC
In-Reply-To: <1523500291-24008-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523500291-24008-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNAShZOxANg1T=9eGgN1MYRVP3qC1n6i8QO07CChPuge-aA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-04-12 11:31 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> The property of the legacy mode for the eMMC PHY turned out to
> be worng.  Some eMMC devices are unstable due to the set-up/hold
> timing violation.  Correct the delay value.

Reminder for myself:
  Fix a type  worng -> wrong



-- 
Best Regards
Masahiro Yamada
