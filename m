From: stevenrwalter@gmail.com (Steven Walter)
Date: Thu, 19 Nov 2009 13:08:01 -0500
Subject: cache aliasing in dup_mmap
In-Reply-To: <20091119085735.GA14178@n2100.arm.linux.org.uk>
References: <20090308143607.GA27349@n2100.arm.linux.org.uk>
	<e06498070909290930w7745e1e3x2e224ad75ff62dbd@mail.gmail.com>
	<20090929191108.GA13568@n2100.arm.linux.org.uk>
	<20091005144623.GA20633@n2100.arm.linux.org.uk>
	<20091105144830.GC21681@n2100.arm.linux.org.uk>
	<e06498070911130649k2051e4cfh2066cf0b9fdabbaf@mail.gmail.com>
	<20091116163028.GA3568@n2100.arm.linux.org.uk>
	<e06498070911160923i2273b6aai6f144b36289203d2@mail.gmail.com>
	<20091116222016.GF3568@n2100.arm.linux.org.uk>
	<20091119085735.GA14178@n2100.arm.linux.org.uk>
Message-ID: <e06498070911191008t1861e730u5cdb49187af00ae0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2009 at 3:57 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> I'm afraid that I have nothing further to suggest, and so I'm shelving
> the patches. ?That means this problem will remain unresolved in future
> kernels.

I had the tester restart the reboot-loop, and so far it's done ~1200
runs with no problem.  I'm thinking now that either I hosed something
up with the build initially, or else the tester didn't flash it
correctly.  1200 runs isn't enough to be conclusive, but it's a lot
better than 88.  I'll let you know when we have something more
definitive.
-- 
-Steven Walter <stevenrwalter@gmail.com>
