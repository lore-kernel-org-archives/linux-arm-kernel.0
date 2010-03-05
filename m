From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Mar 2010 22:51:16 +0000
Subject: [PATCH] ARM: Add Versatile Express SMP support
In-Reply-To: <F01D8B85CFF58440B2A13965FBA90CA404E3EA536A@GEORGE.Emea.Arm.com>
References: <git-1267729916-8545dcd13a3ae6450278b076cb024d10d64ee785@rmk-PC>
	<git-1267729916-22c6a14e4a304af9afdfe1ccf493570f862ba05f@rmk-PC>
	<F01D8B85CFF58440B2A13965FBA90CA404E3EA536A@GEORGE.Emea.Arm.com>
Message-ID: <20100305225116.GC20095@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 05, 2010 at 12:12:33PM +0000, Colin Tuckley wrote:
> > -----Original Message-----
> > From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> > kernel-bounces at lists.infradead.org] On Behalf Of Russell King
> 
> 
> > +++ b/arch/arm/mach-vexpress/headsmp.S
> 
>    <snip>
> 
> > + * Realview specific entry point for secondary CPUs.  This provides
> 
> 
> That "Realview" is incorrect, it could either be removed or replaced
> with "Versatile Express"

Fixed, replaced with "Versatile Express".
