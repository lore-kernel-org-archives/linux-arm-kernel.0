From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 21 Sep 2012 22:41:14 +0000 (UTC)
Subject: rcu self-detected stall messages on OMAP3, 4 boards
In-Reply-To: <20120921212054.GE2454@linux.vnet.ibm.com>
References: <alpine.DEB.2.00.1209122237080.7275@utopia.booyaka.com>
 <20120913011208.GT4257@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209131839000.23318@utopia.booyaka.com>
 <20120920000351.GI2455@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209200753450.3801@utopia.booyaka.com>
 <F95344A7-3351-4E6B-BF61-37E591AF16A2@ti.com>
 <20120920220130.GN2449@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209202244470.32589@utopia.booyaka.com>
 <alpine.DEB.2.00.1209211740170.8839@utopia.booyaka.com>
 <20120921212054.GE2454@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.00.1209212240190.31812@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Sep 2012, Paul E. McKenney wrote:

> On Fri, Sep 21, 2012 at 05:47:31PM +0000, Paul Walmsley wrote:
>
> > I built an OMAP kernel from Linus' commit 
> > 4651afbbae968772efd6dc4ba461cba9b49bb9d8 ("Merge branch 'for-3.6-fixes' of 
> > git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq").  The config used 
> > was 'omap2plus_defconfig', and enabled CONFIG_CPU_IDLE by hand.  Booted it 
> > on a Pandaboard (OMAP4430ES2) into a very minimal Debian rootfs.
> 
> Did you have the patch at https://lkml.org/lkml/2012/8/30/290 applied?

No, it's just as described above.

> If not, could you please try it?  (This patch cleared up a similar
> problem for Becky, also on OMAP.)

Did not seem to help, either with or without CONFIG_CPU_IDLE.


- Paul
