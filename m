From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 16 Sep 2009 00:34:30 +0100
Subject: Samsung S3C6410 / SmartQ / 2D acceleration / Xorg
In-Reply-To: <20090910054942.GB5797@prithivi.gnumonks.org>
References: <20090902031719.GK3838@prithivi.gnumonks.org>
	<200909021203.n82C3USg020804@chronolytics.com>
	<20090910054942.GB5797@prithivi.gnumonks.org>
Message-ID: <20090915233430.GA13508@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 10, 2009 at 02:49:42PM +0900, Harald Welte wrote:
> Dear David,
> 
> > I have a fairly decent SmartQ5/7 config and mach-smartq init file.  Much of
> > this work (that I can test) can be back ported to the smdk6410 (that I can't
> > test. :-)
> 
> So you're hacking on the SmartQ devices?  I recently discovered that they exist and I was
> very intrigued in buying one. 

[snip]
 
> yes, a regular userspace Xorg EXA driver makes probably much more sense.
> If the polling turns out to waste too many cycles, we can still think of some
> interrupt-to-userspace delivery mechanism where we don't need to busy-wait
> in the Xorg driver.

does uio support wait-for-interrupt?

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
