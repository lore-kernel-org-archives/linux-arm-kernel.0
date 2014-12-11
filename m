From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 11 Dec 2014 22:00:42 +0300
Subject: arm64 hitting BUG in arch_timer.h
In-Reply-To: <1418245000.23374.26.camel@t520.localdomain>
References: <1418245000.23374.26.camel@t520.localdomain>
Message-ID: <5489E9DA.8000504@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12/10/2014 11:56 PM, Mark Salter wrote:

> Using Linus' tree from this morning, I am hitting:

>     [    0.000000] BUG: failure at ./arch/arm64/include/asm/arch_timer.h:112/arch_counter_get_cntpct!

> This is triggered by commit 0b46b8a718 ("clocksource: arch_timer: Fix
> code to use physical timers when requested") which addresses an armv7
> problem. Arm64 wants to always use a virtual timer. I used this to avoid
> the BUG and get a booting kernel:

    You didn't sign off on the patch, so it can't be applied.

[...]

WBR, Sergei
