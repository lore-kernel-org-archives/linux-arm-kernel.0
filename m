From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 26 Aug 2010 13:05:32 +0200
Subject: [PATCH/RFCv4 0/6] The Contiguous Memory Allocator framework
In-Reply-To: <AANLkTikS9Bc1NmCCO5w=pT+LBLaeSyk2PBnAry+oDxM8@mail.gmail.com>
References: <cover.1282286941.git.m.nazarewicz@samsung.com>
	<1282310110.2605.976.camel@laptop>
	<20100825155814.25c783c7.akpm@linux-foundation.org>
	<20100825173125.0855a6b0@bike.lwn.net>
	<AANLkTinPaq+0MbdW81uoc5_OZ=1Gy_mVYEBnwv8zgOBd@mail.gmail.com>
	<1282810811.1975.246.camel@laptop>
	<AANLkTin7EBZw0-WY=NGOmYzZT5Cfy7oWVFBaT2cjK+vZ@mail.gmail.com>
	<1282817160.1975.476.camel@laptop>
	<AANLkTikS9Bc1NmCCO5w=pT+LBLaeSyk2PBnAry+oDxM8@mail.gmail.com>
Message-ID: <1282820732.1975.606.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even more offtopic ;-)

On Thu, 2010-08-26 at 19:21 +0900, Minchan Kim wrote:
> I agree highmem isn't a gorgeous. But my desktop isn't real machine?
> Important thing is that we already have a highmem and many guys
> include you(kmap stacking patch :))try to improve highmem problems. :)

I have exactly 0 machines in daily use that use highmem, I had to test
that kmap stuff in a 32bit qemu.

Sadly some hardware folks still think its a sane thing to do, like ARM
announcing 40bit PAE, I mean really?!

At least AMD announced a 64bit tiny-chip and hopefully Intel Atom will
soon be all 64bit too (please?!).
