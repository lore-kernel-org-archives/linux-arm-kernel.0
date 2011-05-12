From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 May 2011 10:05:27 +0100
Subject: [PATCH] ARM: Suspend: Fix build error on ARCH_S5PC100
In-Reply-To: <07e601cc0865$b08be8e0$11a3baa0$%kim@samsung.com>
References: <1301710155-16373-1-git-send-email-kgene.kim@samsung.com>
	<20110402091904.GH8482@n2100.arm.linux.org.uk>
	<02c701cbf2be$0ebebb80$2c3c3280$%kim@samsung.com>
	<20110428184332.GK17290@n2100.arm.linux.org.uk>
	<07e601cc0865$b08be8e0$11a3baa0$%kim@samsung.com>
Message-ID: <20110512090527.GB1356@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 02, 2011 at 10:09:55AM +0900, Kukjin Kim wrote:
> Russell King - ARM Linux wrote:
> > 
> > On Mon, Apr 04, 2011 at 08:47:17PM +0900, Kukjin Kim wrote:
> > > Russell King - ARM Linux wrote:
> > > >
> > > > On Sat, Apr 02, 2011 at 11:09:15AM +0900, Kukjin Kim wrote:
> > > > > The current mainline codes of ARCH_S5PC100 can not support
> > > > > suspend to ram. So needs this for preventing build error.
> > > > >
> > > > > Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> > > > > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > > > > ---
> > > > > Oops, I missed this in my previous patch.
> > > > >
> > > > > As I know, firstly ARCH_S5P64X0 will support suspend to ram
> > > > > then ARCH_S5PC100 will do it. But right now, we need this.
> > > >
> > > > I'd much rather do this a different way - let me know if this means
> > > > the SoC based dependencies can be dropped.  Patches to follow.
> > >
> > > Yeah, I checked your patches. It's ok to me but this is also needed
> right
> > > now for preventing build errors with s5pc100_defconfig...because there
> is
> > no
> > > regarding headers for supporting suspend to ram.
> > >
> > > However as I mentioned, the suspend to ram will be supported soon on
> them
> > > then we can drop its dependencies.
> > 
> > Could I have an updated patch which applies to mainline please?
> 
> From: Kukjin Kim <kgene.kim@samsung.com>
> Date: Mon, 2 May 2011 09:33:01 +0900
> Subject: [PATCH] ARM: Suspend: Fix build error on ARCH_S5PC100
> 
> The current mainline codes of ARCH_S5PC100 cannot support
> suspend to ram. So needs this for preventing build error.
> 
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>

Looks fine, but can it go to the patch system please?
