From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 10 Dec 2013 00:34:17 +0300
Subject: OMAP baseline test results for v3.13-rc1 (toolchain Debian
 4.7.2-5)
In-Reply-To: <20131209191452.GA13171@atomide.com>
References: <alpine.DEB.2.02.1311250731410.1364@utopia.booyaka.com>
 <alpine.DEB.2.02.1311251514330.1364@utopia.booyaka.com>
 <alpine.DEB.2.02.1312090936530.32309@utopia.booyaka.com>
 <20131209171618.GC11433@atomide.com> <20131209191452.GA13171@atomide.com>
Message-ID: <52A63759.70601@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12/09/2013 10:14 PM, Tony Lindgren wrote:

>>>>> Boot to userspace:
>>>>>      FAIL ( 1/11): 37xxevm

>>>> So looks like this is due to the switchover to DT-based booting for 37xx
>>>> EVM.  Will plug that in here and re-test.

>>> Here's the updated test report.  Looks like dynamic idle PM tests are
>>> failing on the 37xxevm now.

>> Off-idle and wake-up events work but need these two pending patches:

>> 1. [PATCH] of/platform: Fix no irq domain found errors when populating interrupts
>>     http://lkml.org/lkml/2013/11/22/520

> Oops, this is the wrong patch, it should be:

> 1. [PATCH] of/platform: Fix no irq domain found errors when populating interrupts
>     http://lkml.org/lkml/2013/11/22/520

    Isn't it the same patch and link? :-)

WBR, Sergei
