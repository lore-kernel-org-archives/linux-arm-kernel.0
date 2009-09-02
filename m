From: laforge@gnumonks.org (Harald Welte)
Date: Thu, 3 Sep 2009 07:26:41 +0900
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <20090902191026.GO25153@trinity.fluff.org>
References: <20090902031719.GK3838@prithivi.gnumonks.org>
	<19987914.1168001251884594226.JavaMail.coremail@bj126app54.126.com>
	<20090902120159.GT32606@prithivi.gnumonks.org>
	<20090902191026.GO25153@trinity.fluff.org>
Message-ID: <20090902222641.GY32606@prithivi.gnumonks.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 02, 2009 at 08:10:26PM +0100, Ben Dooks wrote:
> On Wed, Sep 02, 2009 at 09:01:59PM +0900, Harald Welte wrote:
> > On Wed, Sep 02, 2009 at 05:43:14PM +0800, tommy.hong wrote:
> > 
> > > does it support X kdrive 2D accelerate ?
> > 
> > X / kdrive is not part of the linux kernel.  Therefore, it is unrelated
> > to the Linux kernel code that we are working on.
> 
> Unfortunately it seems that pretty much no-one uses the fb driver
> acceleration, I'm not even sure if it has even been exported outside
> the kernel, so isn't really a lot of use.

having cursor acceleration and things like bitblit for srolling is a real
pleasure if you ever happen to work for more than 5 minutes on the framebuffer
console, especially on a system that already has a quite high load at that time.

It sort-of is a standard feature, and at least in the x86/PCI/AGP world, I
am not awaer that any framebuffer driver would not support it.  That's why I
had it on my todo list.

-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
