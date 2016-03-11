From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 11 Mar 2016 11:56:07 +0530
Subject: [PATCH] dma: sun4i: expose block size and wait cycle
 configuration to DMA users
In-Reply-To: <20160309120627.67612b1d@bbrezillon>
References: <1457344771-12946-1-git-send-email-boris.brezillon@free-electrons.com>
 <20160307145429.GG11154@localhost>
 <20160307160857.577bb04d@bbrezillon>
 <20160307203024.GD8418@lukather> <20160308025547.GI11154@localhost>
 <20160309120627.67612b1d@bbrezillon>
Message-ID: <20160311062607.GP11154@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 09, 2016 at 12:06:27PM +0100, Boris Brezillon wrote:
> On Tue, 8 Mar 2016 08:25:47 +0530
> Vinod Koul <vinod.koul@intel.com> wrote:
> > 
> > Why does dmaengine need to wait? Can you explain that
> 
> I don't have an answer for that one, but when I set WAIT_CYCLES to 1
> for the NAND use case it does not work. So I guess it is somehow
> related to how the DRQ line is controlled on the device side...

Is the WAIT cycle different for different usages or same for all
usages/channels?

-- 
~Vinod
