From: p.pisati@gmail.com (Paolo Pisati)
Date: Mon, 25 Feb 2013 15:20:48 +0100
Subject: omap4: 3.8: IPV6 + PREEMPT_VOLUNTARY + !DEBUG_[SPINLOCK|MUTEXES]
 = BUG()
In-Reply-To: <20130222123637.GA30923@n2100.arm.linux.org.uk>
References: <20130221094819.GA4580@luxor.wired.org>
 <20130222123637.GA30923@n2100.arm.linux.org.uk>
Message-ID: <20130225142048.GA6616@luxor.wired.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 22, 2013 at 12:36:37PM +0000, Russell King - ARM Linux wrote:
> On Thu, Feb 21, 2013 at 10:48:19AM +0100, Paolo Pisati wrote:
> > any idea how can i debug this?
> 
> Please try this patch, and report back whether it solves your problem.
> Thanks.

yes, it solves my problem: any chance we can see it in 3.9 or 3.8.x?

-- 
bye,
p.
