From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 2 Sep 2009 20:10:26 +0100
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <20090902120159.GT32606@prithivi.gnumonks.org>
References: <20090902031719.GK3838@prithivi.gnumonks.org>
	<19987914.1168001251884594226.JavaMail.coremail@bj126app54.126.com>
	<20090902120159.GT32606@prithivi.gnumonks.org>
Message-ID: <20090902191026.GO25153@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 02, 2009 at 09:01:59PM +0900, Harald Welte wrote:
> On Wed, Sep 02, 2009 at 05:43:14PM +0800, tommy.hong wrote:
> 
> > does it support X kdrive 2D accelerate ?
> 
> X / kdrive is not part of the linux kernel.  Therefore, it is unrelated
> to the Linux kernel code that we are working on.

Unfortunately it seems that pretty much no-one uses the fb driver
acceleration, I'm not even sure if it has even been exported outside
the kernel, so isn't really a lot of use.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
