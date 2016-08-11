From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 11 Aug 2016 19:09:00 +0200 (CEST)
Subject: [PATCH 1/1] ARM: dts: imx6q-evi: Use GPIO_6 for fec irq
In-Reply-To: <1470934446-22536-1-git-send-email-stillcompiling@gmail.com>
References: <1470934446-22536-1-git-send-email-stillcompiling@gmail.com>
Message-ID: <745430359.250170.752d0f22-93a7-46e8-bb14-c884787aaea3.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joshua,

> Joshua Clayton <stillcompiling@gmail.com> hat am 11. August 2016 um 18:54
> geschrieben:
> 
> 
> Apply hardware workaround for ethernet problem
> See nxp erratum err006687

do you know this commit?

https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=a28eeb43ee57e0524c59e64760ed28088dd159cb

Maybe you want to add this property, too.
