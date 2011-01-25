From: will.deacon@arm.com (Will Deacon)
Date: Tue, 25 Jan 2011 14:19:39 -0000
Subject: [PATCH 02/14] ARM: bitops: switch set/clear/change bitops to	use
	ldrex/strex
In-Reply-To: <20110125141153.GA17286@n2100.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1Peue4-0003SN-Gk@rmk-PC.arm.linux.org.uk>
	<20110123001636.GA20841@n2100.arm.linux.org.uk>
	<000601cbbc97$cc6955d0$653c0170$@deacon@arm.com>
	<20110125141153.GA17286@n2100.arm.linux.org.uk>
Message-ID: <000c01cbbc9a$e71faf70$b55f0e50$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > I've tested this on the Versatile Express (ca9x4, little endian) with a USB
> > hard drive and ext3 (rw) filesystem. I did a bunch of parallel dds of a 2GB
> > file containing random data whilst the system was fairly loaded. File checksums
> > all passed and the kernel didn't do anything untowards.
> >
> > Tested-by: Will Deacon <will.deacon@arm.com>
> >
> > I appreciate this is the same test configuration as the one Nicolas did,
> > but it at least replicates his findings.
> 
> Was this for just the first three or the complete set?

This was for your -devel branch as of last night (head 75c4aa97).
If I try to extract patches from the mailing list, Exchange destroys
them :(

Will
