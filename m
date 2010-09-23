From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 23 Sep 2010 15:53:05 -0600
Subject: [PATCH] ARM: abstract atags parsing
In-Reply-To: <20100923213113.GC26295@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1009231713570.13233@xanadu.home>
	<20100923213113.GC26295@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikwT-w_6Y+yzZ014g6tijUTUzZUAa7g=eE8F+nt@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 23, 2010 at 3:31 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Sep 23, 2010 at 05:18:02PM -0400, Nicolas Pitre wrote:
>> This code movement will make it cleaner and easier to introduce support
>> for device tree which is basically an alternative to atags. No functional
>> changes are introduced by this patch.
>
> I don't see any point to this churn.

I can carry it in test-devicetree branch until you become okay with it.

> DT has yet to be shown to be useful on anything but the ARM evaluation
> boards, and that's one of the pre-conditions to it becoming acceptable
> (which has been pending for a few years now.)

I started working on ARM DT support in November/December 2009.  Not
even a year yet.

g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
