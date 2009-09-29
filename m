From: stevenrwalter@gmail.com (Steven Walter)
Date: Tue, 29 Sep 2009 12:30:27 -0400
Subject: cache aliasing in dup_mmap
In-Reply-To: <e06498070909290925q55777041q6f3ecfaf9847babb@mail.gmail.com>
References: <e06498070903061426o5875ad13hc6328aa0d3f08ed7@mail.gmail.com>
	<20090306225525.GB3212@n2100.arm.linux.org.uk>
	<e06498070903062020s22222594h7be318fb9f3fdaee@mail.gmail.com>
	<ca992f110903080105ye955070t260e6a4334186986@mail.gmail.com>
	<20090308121029.GA21277@n2100.arm.linux.org.uk>
	<20090308143607.GA27349@n2100.arm.linux.org.uk>
	<e06498070909290925q55777041q6f3ecfaf9847babb@mail.gmail.com>
Message-ID: <e06498070909290930w7745e1e3x2e224ad75ff62dbd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 8, 2009 at 10:36 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Mar 08, 2009 at 12:10:29PM +0000, Russell King - ARM Linux wrote:
>> I don't think moving flush_cache_mm solves anything - the problem remains,
>> but with a different timing.
>
> On the other hand, this should solve the problem. ?I'm not 100% happy
> with this because we end up using the cache flush ops on the same memory
> several times.

Russell

It appears that this patch is neither in Linus' tree nor the ARM
master branch. ?Was a different fix committed to address the original
memory corruption issue?
--
-Steven Walter <stevenrwalter@gmail.com>
