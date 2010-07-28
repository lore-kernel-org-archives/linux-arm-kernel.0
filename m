From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 28 Jul 2010 20:49:38 +0100
Subject: [PATCH] arm/mach-ixp2000: Add missing comma - fix build failure
In-Reply-To: <20100728191531.GA10719@shutemov.name>
References: <201007282043.13561.PeterHuewe@gmx.de>
	<20100728191531.GA10719@shutemov.name>
Message-ID: <20100728194938.GA5772@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 28, 2010 at 10:15:31PM +0300, Kirill A. Shutemov wrote:
> On Wed, Jul 28, 2010 at 08:43:13PM +0200, Peter Huewe wrote:
> > From: Peter Huewe <peterhuewe@gmx.de>
> > 
> > This trivial patch fixes a build failure [1] by adding a missing comma.
> 
> It has been fixed by updated patch:
> 
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6269/1

And committed.  I want to give the MMCI changes I've committed yesterday
a run before I push the tree out though.
