From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 22 Jul 2011 09:18:46 +0100
Subject: linux-next regression on ARM926
In-Reply-To: <CA+wbFddfkSAeg95YpPQ42qTxmfjjfKyop+z0zJxiEvEE3ScMFQ@mail.gmail.com>
References: <CACRpkdbBrVda2oD42tjrWiG6uHXAdWwpr6cZ7qnSc2KM82XCfw@mail.gmail.com>
	<20110718112757.GV23270@n2100.arm.linux.org.uk>
	<CA+wbFdfNAjqQf4T48_cVbNOb6ac84TQC-2QvHKD43dfRou-i9w@mail.gmail.com>
	<20110719110904.GJ26574@n2100.arm.linux.org.uk>
	<CA+wbFdcifNu1W1BtehSxEMf4G48NhYiCHx+uAGjFuRQ4hr_rLA@mail.gmail.com>
	<20110721134804.GO26574@n2100.arm.linux.org.uk>
	<CA+wbFdeohxm64qpDs+i4TaYBeL0vjqeG6LU0_3VucZ0hvVxCMQ@mail.gmail.com>
	<20110721165210.GD20310@n2100.arm.linux.org.uk>
	<CA+wbFddfkSAeg95YpPQ42qTxmfjjfKyop+z0zJxiEvEE3ScMFQ@mail.gmail.com>
Message-ID: <20110722081846.GA2111@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2011 at 06:00:05PM +0100, Dave Martin wrote:
> On Thu, Jul 21, 2011 at 5:52 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Jul 21, 2011 at 05:39:06PM +0100, Dave Martin wrote:
> >> Did you miss proc-v6, or is that touched by some other patch? ?I
> >> already have the relevant patch, so I'm happy to post that if you
> >> don't already have it.
> >
> > Well spotted, I've just corrected that.
> 
> I think that should be all of them -- I had hacked up a quick script
> to find and change all instances, but proc-v6 was the only one it
> touched which wasn't in your series.

I didn't mention, but you can add my ack to the patch for proc-v6 as well
(though you probably did already, which is fine.)

Cheers
---Dave
