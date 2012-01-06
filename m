From: nsekhar@ti.com (Nori, Sekhar)
Date: Fri, 6 Jan 2012 06:53:09 +0000
Subject: [PATCH 2/2] ARM: davinci: convert sched_clock() to use common
 infrastructure
In-Reply-To: <20120103090711.GB2914@n2100.arm.linux.org.uk>
References: <1324663040-2859-1-git-send-email-nsekhar@ti.com>
 <1324663040-2859-2-git-send-email-nsekhar@ti.com>
 <20120103090711.GB2914@n2100.arm.linux.org.uk>
Message-ID: <DF0F476B391FA8409C78302C7BA518B605F899@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell, Linus, 

On Tue, Jan 03, 2012 at 14:37:11, Russell King - ARM Linux wrote:
> On Fri, Dec 23, 2011 at 11:27:20PM +0530, Sekhar Nori wrote:
> > Convert davinci to use the common sched_clock() infrastructure
> > for extending 32bit counters to full 64-bit nanoseconds.
> > 
> > Eventually clocksource timer should be initialized from init_early
> > so there would be no need to use a dummy clocksource read at start.
> 
> Please see patch 7205/2.

Thanks for the pointers. I rebased this series on latest linux-next
and got things working again.

I will post updated patches soon.

Thanks,
Sekhar
