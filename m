From: vinod.koul@intel.com (Koul, Vinod)
Date: Mon, 5 Oct 2015 14:10:03 +0000
Subject: [PATCH v6 2/2] dmaengine: Add Xilinx AXI Central Direct Memory
 Access Engine driver support
In-Reply-To: <C246CAC1457055469EF09E3A7AC4E11A4A4EC176@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1441629198-17663-1-git-send-email-appanad@xilinx.com>
 <20151005133907.GA13501@vkoul-mobl.iind.intel.com>
 <C246CAC1457055469EF09E3A7AC4E11A4A4EC176@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <1444054201.3579.22.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-10-05 at 13:50 +0000, Appana Durga Kedareswara Rao wrote:

> > 
> > On Mon, Sep 07, 2015 at 06:03:18PM +0530, Kedareswara rao Appana wrote:
> > > This is the driver for the AXI Central Direct Memory Access (AXI
> > > CDMA) core, which is a soft Xilinx IP core that provides
> > > high-bandwidth Direct Memory Access (DMA) between a memory-mapped
> > > source address and a memory-mapped destination address.
> > 
> > Where is the 1/2 here ? I have only this one in my mails..
> 
> You are there in the 1/2 not the dmaengine at vger.kernel.org.

The threading is broken in your patch series. ON searching I found the 1/2. Please
make sure patch series are threaded properly.

-- 
~Vinod
