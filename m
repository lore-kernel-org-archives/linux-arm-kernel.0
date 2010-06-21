From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Jun 2010 10:39:44 +0100
Subject: [PATCH v3 7/7] ARM: Do not compile the Thumb-2
	modulerelocations on an ARM kernel
In-Reply-To: <1277113032.20758.6.camel@e102109-lin.cambridge.arm.com>
References: <20100621090801.22752.21039.stgit@e102109-lin.cambridge.arm.com>
	<20100621091404.22752.10456.stgit@e102109-lin.cambridge.arm.com>
	<20100621092611.GD7702@n2100.arm.linux.org.uk>
	<1277113032.20758.6.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100621093944.GG7702@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 21, 2010 at 10:37:12AM +0100, Catalin Marinas wrote:
> On Mon, 2010-06-21 at 10:26 +0100, Russell King - ARM Linux wrote:
> > On Mon, Jun 21, 2010 at 10:14:04AM +0100, Catalin Marinas wrote:
> > > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > 
> > Commit message?  What is the reasoning behind this change?
> > 
> > It'd be useful for those who don't know anything about T2 to have
> > some such information about this change.
> 
> It looks like I forgot to write a description. The reason is just to
> avoid extra code to be compiled in when you don't really need to handle
> such relocations (i.e. ARM-only kernel). Do you think it's not worth?

I think its worth giving other people the information they need to
understand the change if they review the patch.
