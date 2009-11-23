From: jpihet@mvista.com (Jean Pihet)
Date: Mon, 23 Nov 2009 17:20:50 +0100
Subject: [PATCH] check put_user fail in do_signal when enable OABI_COMPACT
In-Reply-To: <20091123140650.GC18142@n2100.arm.linux.org.uk>
References: <1256123277.3851.36.camel@debian-nb>
	<200911231459.13622.jpihet@mvista.com>
	<20091123140650.GC18142@n2100.arm.linux.org.uk>
Message-ID: <200911231720.50378.jpihet@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 November 2009 15:06:50 Russell King - ARM Linux wrote:
> On Mon, Nov 23, 2009 at 02:59:13PM +0100, Jean Pihet wrote:
> > Russell,
> >
> > On Wednesday 04 November 2009 20:32:44 Russell King - ARM Linux wrote:
> > > On Wed, Nov 04, 2009 at 02:33:31PM +0100, Jean Pihet wrote:
> > > > Is this one OK? Can it be merged now that your fix for signal restart
> > > > has been merged into mainline?
> > >
> > > Yes.
> >
> > May I ask you again to merge the patch? Is this one supposed to reach
> > into mainline via your tree?
>
> I have a patch system to avoid patches being dropped like this... I'm
> really *bad* with emailed patches.
>
> Please submit to the patch system, thanks.
Ah ok! It is submitted as patch 5793/1.

Thanks,
Jean
