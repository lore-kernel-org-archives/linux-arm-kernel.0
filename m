From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 10 Apr 2010 08:03:05 +0100
Subject: [RFC] Initial attempt to make ARM use LMB
In-Reply-To: <20100410034224.GA22637@debian>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk>
	<20100408153111.GA2598@debian>
	<20100408182715.GF31407@n2100.arm.linux.org.uk>
	<20100409111105.GA2804@n2100.arm.linux.org.uk>
	<20100410034224.GA22637@debian>
Message-ID: <20100410070305.GA2445@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 10, 2010 at 09:12:24AM +0530, Rabin Vincent wrote:
> On Fri, Apr 09, 2010 at 12:11:05PM +0100, Russell King - ARM Linux wrote:
> > Here's a revised version which should resolve the initrd problem.
> 
> It does, after the missing call to lmb_init() is added.

Which missing call?
