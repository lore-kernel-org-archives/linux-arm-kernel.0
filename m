From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 26 Sep 2015 15:24:35 +0900
Subject: Debug UART for arm64 ?
Message-ID: <CAK7LNAQcBeQfRFf25HYOnN60rnb4uU=d=Ogas+-b1TCRMAxMJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.


Forgive me if I am asking a silly question.


I will have to port ARM64 Linux on our new SoC.
This is my first work on ARM64 Linux,
so I have no experience with it yet.

When I worked on ARM32 Linux porting for the first time,
lowlevel-debug UART (CONFIG_DEBUG_LL) was very useful for me.

With my quick search under arch/arm64/ directory,
I could not find an equivalent one for ARM64.


Is debug UART available for ARM64?
Or, is there any other recommended easy-to-use debug facility
when something like a JTAG-debugger is unavailable.




-- 
Best Regards
Masahiro Yamada
