From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Sun, 20 Nov 2016 14:02:17 +0100
Subject: commit 4dd1837d7589f468ed109556513f476e7a7f9121 breaks build
In-Reply-To: <20161120123422.GT1041@n2100.armlinux.org.uk>
References: <58310EC6.4020402@math.uni-bielefeld.de>
 <20161120113007.GS1041@n2100.armlinux.org.uk>
 <58318C6A.50104@math.uni-bielefeld.de>
 <20161120123422.GT1041@n2100.armlinux.org.uk>
Message-ID: <20161120130217.GB19562@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 20, 2016 at 12:34:22PM +0000, Russell King - ARM Linux wrote:
> On Sun, Nov 20, 2016 at 12:43:38PM +0100, Tobias Jakobi wrote:
> > Hello Russell,
> > 
> > Russell King - ARM Linux wrote:
> > > None of the autobuilders are finding this problem, and they build a
> > > wide range of configurations.  Maybe it's something specific to how
> > > you're building the kernel - can you give step by step instructions
> > > how to reproduce this please?
> > Just using plain make here, no cross-compiler or anything involved. gcc
> > is version 4.9.4.
> 
> Hmm.  The commit you mention was merged during the merge window, so
> anyone building 4.9-rc1 or later should be seeing this problem, but
> they aren't.  I've built many kernels post -rc1, and I'm not seeing
> the problem with my 4.7.4 cross compiler.
> 

I have the same issue here on all my Allwinner ARM device.
I have not reported this issue since I believed to see some report of it.

I cross compile with armv7a-hardfloat-linux-gnueabi-4.9.3.

With CONFIG_UNUSED_SYMBOLS set, the issue disapear

Regards
