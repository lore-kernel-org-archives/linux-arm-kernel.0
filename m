From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 17 Jan 2011 21:16:03 +0100
Subject: [uclinux-dist-devel] [PATCH] sched: provide scheduler_ipi()
	callback in response to smp_send_reschedule()
In-Reply-To: <AANLkTik3hE=_34Lbs944MzKpkNzqY+kCxpxmncUM2HB7@mail.gmail.com>
References: <1295262433.30950.53.camel@laptop>
	<AANLkTik3hE=_34Lbs944MzKpkNzqY+kCxpxmncUM2HB7@mail.gmail.com>
Message-ID: <1295295363.30950.318.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-01-17 at 14:49 -0500, Mike Frysinger wrote:
> On Mon, Jan 17, 2011 at 06:07, Peter Zijlstra wrote:
> > Also, while reading through all this, I noticed the blackfin SMP code
> > looks to be broken, it simply discards any IPI when low on memory.
> 
> not really.  see changelog of commit 73a400646b8e26615f3ef1a0a4bc0cd0d5bd284c.

Ah, indeed, it appears my tree was simply out of date, very good!
