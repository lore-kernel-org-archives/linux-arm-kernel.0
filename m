From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Sun, 23 Sep 2012 05:11:12 -0700
Subject: rcu self-detected stall messages on OMAP3, 4 boards
In-Reply-To: <alpine.DEB.2.00.1209230753120.7868@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209211803290.8839@utopia.booyaka.com>
 <20120921185827.GC2454@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209211900520.8839@utopia.booyaka.com>
 <20120921195717.GD2454@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209221836070.10663@utopia.booyaka.com>
 <20120922201043.GE2934@linux.vnet.ibm.com>
 <20120922215923.GA13161@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209222223080.22590@utopia.booyaka.com>
 <20120922231121.GH2934@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209230753120.7868@utopia.booyaka.com>
Message-ID: <20120923121112.GK2934@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 23, 2012 at 07:55:50AM +0000, Paul Walmsley wrote:
> On Sat, 22 Sep 2012, Paul E. McKenney wrote:
> 
> > On Sat, Sep 22, 2012 at 10:25:59PM +0000, Paul Walmsley wrote:
> > 
> > > The recent tests here have been on Pandaboard, which is dual-CPU, but my 
> > > recollection is that I also observed the warnings on a single-core 
> > > Beagleboard.  Will re-test.
> > 
> > Anxiously awaiting the results.
> 
> The same problem exists on BeagleBoard XM (OMAP3730, single-core 
> Cortex-A8):
> 
>    http://www.pwsan.com/omap/transcripts/20120922-beaglexm-rcu-stall-debug-pre-fix.txt
> 
> and the same patch fixes it:
> 
>    http://www.pwsan.com/omap/transcripts/20120922-beaglexm-rcu-stall-debug-post-fix.txt
> 
> Please feel free to update my Tested-by:, if you wish.
> 
> Tested-by: Paul Walmsley <paul@pwsan.com>  # OMAP3730, OMAP4430

Very good, thank you very much!!!

							Thanx, Paul
