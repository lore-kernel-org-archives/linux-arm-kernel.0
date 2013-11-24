From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 24 Nov 2013 10:11:23 +0000
Subject: [GIT PULL] prefetch support for 3.13
In-Reply-To: <5291CCBF.8030608@gmail.com>
References: <20131009171312.GJ8378@mudshark.cambridge.arm.com>
 <5291CCBF.8030608@gmail.com>
Message-ID: <20131124101123.GL16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 24, 2013 at 10:54:07AM +0100, Dirk Behme wrote:
> Would this patch series be a candidate for the -stable kernels as  
> discussed recently in the "Patches from ARM folks solicited for the  
> -stable tree" thread?

I don't think so.

Firstly, patches suitable for the stable tree are also suitable to be
pushed in during -rc time.  In other words, they're bug fixes and
regression fixes.  This is neither.

Secondly, it has the effect that it raises the bar on the binutils to
build the kernel, and if we push that into -stable kernels, those kernels
will fail to build with older binutils - which is itself a regression
as far as -stable is concerned.

So no, I don't think it's appropriate.
