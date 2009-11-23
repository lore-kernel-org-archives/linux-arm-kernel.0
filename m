From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Nov 2009 14:06:50 +0000
Subject: [PATCH] check put_user fail in do_signal when enable OABI_COMPACT
In-Reply-To: <200911231459.13622.jpihet@mvista.com>
References: <1256123277.3851.36.camel@debian-nb>
	<200911041433.32010.jpihet@mvista.com>
	<20091104193244.GC518@n2100.arm.linux.org.uk>
	<200911231459.13622.jpihet@mvista.com>
Message-ID: <20091123140650.GC18142@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2009 at 02:59:13PM +0100, Jean Pihet wrote:
> Russell,
> 
> On Wednesday 04 November 2009 20:32:44 Russell King - ARM Linux wrote:
> > On Wed, Nov 04, 2009 at 02:33:31PM +0100, Jean Pihet wrote:
> > > Is this one OK? Can it be merged now that your fix for signal restart
> > > has been merged into mainline?
> >
> > Yes.
> May I ask you again to merge the patch? Is this one supposed to reach into 
> mainline via your tree?

I have a patch system to avoid patches being dropped like this... I'm
really *bad* with emailed patches.

Please submit to the patch system, thanks.
