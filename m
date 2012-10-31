From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Wed, 31 Oct 2012 05:29:05 +0000
Subject: [PATCH 00/13] ARM: OMAP: remove prcm.[ch]
In-Reply-To: <alpine.DEB.2.00.1210301156310.12697@utopia.booyaka.com>
References: <20121025231818.17558.57884.stgit@dusk.lan>
 <508E5B65.2020800@ti.com>
 <alpine.DEB.2.00.1210301156310.12697@utopia.booyaka.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EB52A6E@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 30, 2012 at 17:27:02, Paul Walmsley wrote:
> On Mon, 29 Oct 2012, Vaibhav Hiremath wrote:
> 
> > 
> > 
> > On 10/26/2012 4:51 AM, Paul Walmsley wrote:
> > > Remove arch/arm/mach-omap2/prcm.c and
> > > arch/arm/plat-omap/include/plat/prcm.h.  This is in preparation for
> > > moving the PRM/CM code to drivers/, although to be fair, these files
> > > should have been removed a long time ago.
> > > 
> > > Intended for 3.8 cleanup.  Applies on top of the existing PRM/CM split
> > > cleanup series, and the WDTIMER cleanup series.
> > > 
> > 
> > Paul,
> > 
> > By any chance you have branch available with these patches, so that I
> > can validate them here at my end?
> 
> The current version is at
> 
> git://git.pwsan.com/linux-2.6
> 
> in the branch
> 
> prcm_cleanup_b_3.8
> 

Boot tested on BeagleBone platform.

Tested-By: Vaibhav Hiremath <hvaibhav@ti.com>

Thanks,
Vaibhav

> 
> - Paul
> 
