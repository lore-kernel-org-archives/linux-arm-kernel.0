From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 4 Feb 2010 19:27:39 +0000
Subject: [RFC PATCH 1/3] [ARM] allow NR_IRQS to be larger than 256
In-Reply-To: <f17812d71002041118r584bea0em3e39f6ed47c29783@mail.gmail.com>
References: <f17812d71002041109u3d7ea08ej201708fa462e087d@mail.gmail.com>
	<20100204191402.GE27344@n2100.arm.linux.org.uk>
	<f17812d71002041118l48578700t71f8ad018fe31ab1@mail.gmail.com>
	<f17812d71002041118r584bea0em3e39f6ed47c29783@mail.gmail.com>
Message-ID: <20100204192739.GF27344@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2010 at 11:18:52AM -0800, Eric Miao wrote:
> On Thu, Feb 4, 2010 at 11:18 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
> > On Thu, Feb 4, 2010 at 11:14 AM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> >> On Thu, Feb 04, 2010 at 11:09:22AM -0800, Eric Miao wrote:
> >>> commit fc14e7ca387688ca63eafa16d4aa3012898d096d
> >>> Author: Eric Miao <eric.y.miao@gmail.com>
> >>> Date: ? Mon Dec 28 11:05:55 2009 +0800
> >>>
> >>> ? ? [ARM] allow NR_IRQS to be larger than 256
> >>
> >> Don't you mean 512 ?
> >
> > Exactly.
> >
> 
> Maybe a subject of "allow .... to be in range of 256 to 512" will be better.

Which we already do - with 9 hard irq bits if NR_IRQS is larger than 256.
