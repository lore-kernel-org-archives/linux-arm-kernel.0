From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 24 Sep 2010 00:34:22 +0100
Subject: [PATCH] ARM: abstract atags parsing
In-Reply-To: <AANLkTikwT-w_6Y+yzZ014g6tijUTUzZUAa7g=eE8F+nt@mail.gmail.com>
References: <alpine.LFD.2.00.1009231713570.13233@xanadu.home>	<20100923213113.GC26295@n2100.arm.linux.org.uk>
	<AANLkTikwT-w_6Y+yzZ014g6tijUTUzZUAa7g=eE8F+nt@mail.gmail.com>
Message-ID: <4C9BE3FE.1070704@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/09/10 22:53, Grant Likely wrote:
> On Thu, Sep 23, 2010 at 3:31 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Thu, Sep 23, 2010 at 05:18:02PM -0400, Nicolas Pitre wrote:
>>> This code movement will make it cleaner and easier to introduce support
>>> for device tree which is basically an alternative to atags. No functional
>>> changes are introduced by this patch.
>>
>> I don't see any point to this churn.
> 
> I can carry it in test-devicetree branch until you become okay with it.
> 
>> DT has yet to be shown to be useful on anything but the ARM evaluation
>> boards, and that's one of the pre-conditions to it becoming acceptable
>> (which has been pending for a few years now.)
> 
> I started working on ARM DT support in November/December 2009.  Not
> even a year yet.

I don't believe you're the only one to be or have been working on it,
but I've no direct references to other work and can't be bothered to
go and find any.
