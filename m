From: lars@metafoo.de (Lars-Peter Clausen)
Date: Wed, 12 Sep 2012 22:43:07 +0200
Subject: [PATCH] clk: Make the managed clk functions generically available
In-Reply-To: <504FE633.2090304@snapgear.com>
References: <1347202862-1617-1-git-send-email-lars@metafoo.de>
 <20120909235059.GA2643@sirena.org.uk>
 <20120910001524.GL13739@n2100.arm.linux.org.uk>
 <20120910002020.GB16249@opensource.wolfsonmicro.com>
 <20120910003913.GM13739@n2100.arm.linux.org.uk> <504F4E36.20309@metafoo.de>
 <1347375033.27206.3.camel@sauron.fi.intel.com>
 <504FE633.2090304@snapgear.com>
Message-ID: <5050F3DB.1050202@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2012 03:32 AM, Greg Ungerer wrote:
> On 12/09/12 00:50, Artem Bityutskiy wrote:
>> On Tue, 2012-09-11 at 16:44 +0200, Lars-Peter Clausen wrote:
>>> On 09/10/2012 02:39 AM, Russell King - ARM Linux wrote:
>>>> On Mon, Sep 10, 2012 at 08:20:21AM +0800, Mark Brown wrote:
>>>>> [...]
>>>>> OK, that's what I'd thought was going on - it was the fact that you'd
>>>>> just acked the patch rather than asked for it to go to the patch
>>>>> tracker
>>>>> or something which made me wonder if things had changed.
>>>>
>>>> I kind'a forgot because it's been soo long since I took any of those
>>>> patches...
>>>
>>> Ok, what's the plan? Should I add this patch to the patch tracker?
>>
>> I'd propose to send it to Linus for v3.6 even.
> 
> If we do this can we make a decision quickly on it.
> 
> I need to fix a regression on some ColdFire parts for 3.6. I either need
> to use this clk patch, which fixes my problem, or a specific patch for the
> ColdFire clk code http://marc.info/?l=linux-m68k&m=134725225823437&w=2
> 

I wouldn't mind having this merged sooner rather than later, there is at least
one driver in next which is currently broken due to the missing devm_clk_get.
Russell what's your plan for the patch? Maybe under the given circumstances it
makes sense to let it go through the m68k tree.

- Lars
