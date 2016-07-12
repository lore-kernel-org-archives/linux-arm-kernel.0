From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 12 Jul 2016 10:12:48 +0530
Subject: [PATCH v4 0/4] dmaengine driver for Marvell XOR v2 engine
In-Reply-To: <20160707224248.71511ecd@free-electrons.com>
References: <1466080116-26777-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160628143850.GD14945@localhost>
 <20160707224248.71511ecd@free-electrons.com>
Message-ID: <20160712044248.GQ9681@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2016 at 10:42:48PM +0200, Thomas Petazzoni wrote:
> Hello Vinod,
> 
> On Tue, 28 Jun 2016 20:08:50 +0530, Vinod Koul wrote:
> > On Thu, Jun 16, 2016 at 02:28:32PM +0200, Thomas Petazzoni wrote:
> > > Hello,
> > > 
> > > Here is the fourth version of the mv_xor_v2 driver, which allows to
> > > use the XOR engines available on the Marvell Armada 7K/8K ARM64 SoCs.  
> > 
> > Looks okay. But need ack on two ARM patches...
> 
> Now that the two ARM patches have been taken by the ARM mvebu
> maintainer, do you think you could merge the DT binding and driver
> patches (PATCH 1/2 and PATCH 2/2 of this series) ?

Sorry for bit delay, I have applied them now :)

I modified commit of patch 2 for correcting subsystem name

While applying notice git warned of empty newline in the new file, have
remove that as well

-- 
~Vinod
