From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sun, 20 Sep 2009 23:42:58 +0200
Subject: [PATCH 0/5] U300 rebased boardconfig
In-Reply-To: <20090918211017.GN6601@n2100.arm.linux.org.uk>
References: <1253189203-30406-1-git-send-email-linus.walleij@stericsson.com>
	<20090918204259.GL6601@n2100.arm.linux.org.uk>
	<63386a3d0909181354t4cdf94cdodbd78e02f3c3d3df@mail.gmail.com>
	<20090918211017.GN6601@n2100.arm.linux.org.uk>
Message-ID: <63386a3d0909201442k463bac91q34d49eb313fb747c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/9/18 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Fri, Sep 18, 2009 at 10:54:33PM +0200, Linus Walleij wrote:
>> 2009/9/18 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>>
>> > The old u300 branch merges just fine. ?Are there any changes in this
>> > which weren't previously submitted?
>>
>> Wow OK I rephrase so that it not only applies but also compiles...
>>
>> I changed the first sched_clock patch so that it compiles with
>> the revised clocksource framework.
>>
>> The others didn't really change, so if you can revert just the sched_clock
>> one and replace it with the new one everything should be fine.
>
> Done and pushed out in the devel branch - please check it.

Seems to be OK, the devel branch isn't rebased against 2.6 upstream
and the latest fixes to e.g. vic.c so it doesn't compile for U300,
but it looks correct.

Linus Walleij
