From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 18 Jun 2012 09:32:48 +0100
Subject: [PATCH 06/14] mfd: Initialise the DB8500 PRCMU driver at
 core_initcall time
In-Reply-To: <201206121449.22978.arnd@arndb.de>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <201206121259.38807.arnd@arndb.de> <4FD742C9.7090603@linaro.org>
 <201206121449.22978.arnd@arndb.de>
Message-ID: <4FDEE7B0.9070208@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/12 15:49, Arnd Bergmann wrote:
> On Tuesday 12 June 2012, Lee Jones wrote:
>> But your suggestion above involves some heavy refactoring of how Device
>> Tree works. Meanwhile the ab8500 will not work as an IRQ controller
>> until we either complete the work or use the same solution as we did for
>> the Nomadik GPIO controller. I think for now at least we should continue
>> to work on enablement and leave the 'nice to have's until last. We are
>> doing nothing new here, just bringing the ab8500 IRQ controller into
>> line with the Nomadik one.
>
> Right, I didn't say we should not take your patch, but we should be
> aware that it's not the solution we want to use in the long run.

So is it only for this and the other one to go in now?

If so, can I have acks for them please, so I may place them in my 
up-coming pull-request?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
