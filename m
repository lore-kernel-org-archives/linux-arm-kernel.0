From: m.nazarewicz@samsung.com (=?utf-8?B?TWljaGHFgiBOYXphcmV3aWN6?=)
Date: Wed, 20 Jan 2010 15:09:55 +0100
Subject: [PATCH/RFC v1 0/2] Human readable performance event description in
	sysfs
In-Reply-To: <1263996080.4283.1064.camel@laptop>
References: <1263978706-15499-1-git-send-email-t.fujak@samsung.com>
	<1263978999.4283.823.camel@laptop> <op.u6tslipz7p4s8u@pikus>
	<20100120133145.GE4089@wear.picochip.com>
	<1263994779.4283.1057.camel@laptop>
	<20100120135553.GA22897@n2100.arm.linux.org.uk>
	<1263996080.4283.1064.camel@laptop>
Message-ID: <op.u6t4atd07p4s8u@pikus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Jan 2010 15:01:20 +0100, Peter Zijlstra <peterz@infradead.org> wrote:
> It seems to me userspace might care about the exact platform they're
> running on.

In my humble opinion, user space should never care about platform it's
running on.  Interfaces provided by kernel should suffice to implement
abstraction layer between user space and hardware.  If we abandon that
we're back in DOS times.  But hey, again, that's just my opinion.

-- 
Best regards,                                           _     _
  .o. | Liege of Serenely Enlightened Majesty of       o' \,=./ `o
  ..o | Computer Science,  Micha? "mina86" Nazarewicz     (o o)
  ooo +---[mina86 at mina86.com]---[mina86 at jabber.org]---ooO--(_)--Ooo--
