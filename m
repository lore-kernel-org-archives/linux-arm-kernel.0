From: mjg59@srcf.ucam.org (Matthew Garrett)
Date: Fri, 10 Jun 2011 18:23:07 +0100
Subject: [PATCH 00/10] mm: Linux VM Infrastructure to support Memory
	Power Management
In-Reply-To: <20110610171939.GE2230@linux.vnet.ibm.com>
References: <1306499498-14263-1-git-send-email-ankita@in.ibm.com>
	<20110528005640.9076c0b1.akpm@linux-foundation.org>
	<20110609185259.GA29287@linux.vnet.ibm.com>
	<BANLkTinxeeSby_+tta8EhzCg3VbD6+=g+g@mail.gmail.com>
	<20110610151121.GA2230@linux.vnet.ibm.com>
	<20110610155954.GA25774@srcf.ucam.org>
	<20110610165529.GC2230@linux.vnet.ibm.com>
	<20110610170535.GC25774@srcf.ucam.org>
	<20110610171939.GE2230@linux.vnet.ibm.com>
Message-ID: <20110610172307.GA27630@srcf.ucam.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2011 at 10:19:39AM -0700, Paul E. McKenney wrote:
> On Fri, Jun 10, 2011 at 06:05:35PM +0100, Matthew Garrett wrote:
> > I mean at the hardware level. As far as I know, the best we can do at 
> > the moment is to put an entire node into self refresh when the CPU hits 
> > package C6.
> 
> But this depends on the type of system and CPU family, right?  If you
> can say, which hardware are you thinking of?  (I am thinking of ARM.)

I haven't seen too many ARM servers with 256GB of RAM :) I'm mostly 
looking at this from an x86 perspective.

-- 
Matthew Garrett | mjg59 at srcf.ucam.org
