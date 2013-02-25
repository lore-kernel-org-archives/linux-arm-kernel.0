From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 25 Feb 2013 16:14:01 +0000
Subject: omap4: 3.8: IPV6 + PREEMPT_VOLUNTARY +
 !DEBUG_[SPINLOCK|MUTEXES] = BUG()
In-Reply-To: <20130225142048.GA6616@luxor.wired.org>
References: <20130221094819.GA4580@luxor.wired.org>
 <20130222123637.GA30923@n2100.arm.linux.org.uk>
 <20130225142048.GA6616@luxor.wired.org>
Message-ID: <20130225161401.GB30923@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 25, 2013 at 03:20:48PM +0100, Paolo Pisati wrote:
> On Fri, Feb 22, 2013 at 12:36:37PM +0000, Russell King - ARM Linux wrote:
> > On Thu, Feb 21, 2013 at 10:48:19AM +0100, Paolo Pisati wrote:
> > > any idea how can i debug this?
> > 
> > Please try this patch, and report back whether it solves your problem.
> > Thanks.
> 
> yes, it solves my problem: any chance we can see it in 3.9 or 3.8.x?

I was just looking to send a chase for this, because I'm about to
remerge my tree and I wanted this patch committed.

Can I use your name and email address in the commit for the Reported-by
and Tested-by tags (which will be published in the kernel repository)
please?  Thanks.
