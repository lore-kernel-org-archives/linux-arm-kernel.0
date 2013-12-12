From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Dec 2013 12:41:54 +0000
Subject: [REGRESSION,BISECTED] DMA mask issue on ReadyNAS 102 w/ 3.13.0-rc3
In-Reply-To: <20131212123422.GF10053@titan.lakedaemon.net>
References: <87haakfene.fsf@natisbad.org>
 <20131207231958.GS4360@n2100.arm.linux.org.uk> <87eh5ow7m0.fsf@natisbad.org>
 <20131211185445.GC10053@titan.lakedaemon.net>
 <20131211205724.GH4360@n2100.arm.linux.org.uk>
 <20131212123422.GF10053@titan.lakedaemon.net>
Message-ID: <20131212124154.GM4360@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 07:34:22AM -0500, Jason Cooper wrote:
> On Wed, Dec 11, 2013 at 08:57:24PM +0000, Russell King - ARM Linux wrote:
> > On Wed, Dec 11, 2013 at 01:54:45PM -0500, Jason Cooper wrote:
> > > I don't see this in any of your branches.  Is there anything else you
> > > need from us to get this merged?
> > 
> > Where are you looking?
> 
> I looked in for-linus-dma-masks, unstable/dma-masks, and fixes branches
> at:
> 
>   http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-arm.git
> 
> That was yesterday, and I just did another quick check this morning.
> Nothing jumps out at me.  Did I miss something obvious?

Yes.  9f28cde0bc643186d32744ce69d12222e8588fe7, which is definitely in
the fixes branch.
