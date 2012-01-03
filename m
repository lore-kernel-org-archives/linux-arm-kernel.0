From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Jan 2012 09:07:11 +0000
Subject: [PATCH 2/2] ARM: davinci: convert sched_clock() to use common
 infrastructure
In-Reply-To: <1324663040-2859-2-git-send-email-nsekhar@ti.com>
References: <1324663040-2859-1-git-send-email-nsekhar@ti.com>
 <1324663040-2859-2-git-send-email-nsekhar@ti.com>
Message-ID: <20120103090711.GB2914@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 23, 2011 at 11:27:20PM +0530, Sekhar Nori wrote:
> Convert davinci to use the common sched_clock() infrastructure
> for extending 32bit counters to full 64-bit nanoseconds.
> 
> Eventually clocksource timer should be initialized from init_early
> so there would be no need to use a dummy clocksource read at start.

Please see patch 7205/2.
