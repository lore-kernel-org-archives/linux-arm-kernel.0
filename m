From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 07 Mar 2013 10:14:19 +0900
Subject: [PATCH] ARM: S3C24XX: drop "select MACH_N35"
In-Reply-To: <20130307005206.GZ17833@n2100.arm.linux.org.uk>
References: <1362609234.28137.2.camel@x61.thuisdomein>
 <013a01ce1ac7$11b287d0$35179770$%kim@samsung.com>
 <1362615081.28137.5.camel@x61.thuisdomein>
 <014601ce1acd$bc63d480$352b7d80$%kim@samsung.com>
 <20130307005206.GZ17833@n2100.arm.linux.org.uk>
Message-ID: <015001ce1ad1$185e66d0$491b3470$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> 
> On Thu, Mar 07, 2013 at 09:50:17AM +0900, Kukjin Kim wrote:
> > Paul Bolle wrote:
> > >
> > > On Thu, 2013-03-07 at 09:02 +0900, Kukjin Kim wrote:
> > >
> > > > BTW, so the machine type can be removed at arch/arm/tools/mach-types
> as
> > > well.
> > >
> > > Well, that file has a big comment on top, containing the line:
> > >     Please do not send patches to this file; it is automatically
> > > generated!
> > >
> > > So I didn't dare to touch it.
> > >
> > Yeah, I know.
> >
> > It will be handled by Russell King :-)
> 
> And deleting entries from it is pointless if they've ever been in the
> kernel.

OK, I see and agree.

Thanks.

- Kukjin
