From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Fri, 10 Jun 2011 10:52:48 -0700
Subject: [PATCH 00/10] mm: Linux VM Infrastructure to support Memory
	Power Management
In-Reply-To: <20110610172307.GA27630@srcf.ucam.org>
References: <1306499498-14263-1-git-send-email-ankita@in.ibm.com>
	<20110528005640.9076c0b1.akpm@linux-foundation.org>
	<20110609185259.GA29287@linux.vnet.ibm.com>
	<BANLkTinxeeSby_+tta8EhzCg3VbD6+=g+g@mail.gmail.com>
	<20110610151121.GA2230@linux.vnet.ibm.com>
	<20110610155954.GA25774@srcf.ucam.org>
	<20110610165529.GC2230@linux.vnet.ibm.com>
	<20110610170535.GC25774@srcf.ucam.org>
	<20110610171939.GE2230@linux.vnet.ibm.com>
	<20110610172307.GA27630@srcf.ucam.org>
Message-ID: <20110610175248.GF2230@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2011 at 06:23:07PM +0100, Matthew Garrett wrote:
> On Fri, Jun 10, 2011 at 10:19:39AM -0700, Paul E. McKenney wrote:
> > On Fri, Jun 10, 2011 at 06:05:35PM +0100, Matthew Garrett wrote:
> > > I mean at the hardware level. As far as I know, the best we can do at 
> > > the moment is to put an entire node into self refresh when the CPU hits 
> > > package C6.
> > 
> > But this depends on the type of system and CPU family, right?  If you
> > can say, which hardware are you thinking of?  (I am thinking of ARM.)
> 
> I haven't seen too many ARM servers with 256GB of RAM :) I'm mostly 
> looking at this from an x86 perspective.

But I have seen ARM embedded systems with CPU power consumption in
the milliwatt range, which greatly reduces the amount of RAM required
to get significant power savings from this approach.  Three orders
of magnitude less CPU power consumption translates (roughly) to three
orders of magnitude less memory required -- and embedded devices with
more than 256MB of memory are quite common.

							Thanx, Paul
