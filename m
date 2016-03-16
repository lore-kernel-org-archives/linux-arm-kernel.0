From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 16 Mar 2016 08:41:16 +0530
Subject: [PATCH 0/7] dmaengine: xilinx_vdma: AXI DMA's enhancments
In-Reply-To: <CAAtXAHe+gbVg866STE_EVGnK6=omjm=GHGsqHGZ3J+uRq5J-Zg@mail.gmail.com>
References: <1458062592-27981-1-git-send-email-appanad@xilinx.com>
 <CAAtXAHe+gbVg866STE_EVGnK6=omjm=GHGsqHGZ3J+uRq5J-Zg@mail.gmail.com>
Message-ID: <20160316031116.GM13211@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 15, 2016 at 06:29:38PM -0700, Moritz Fischer wrote:
> Hi,
> 
> On Tue, Mar 15, 2016 at 10:23 AM, Kedareswara rao Appana
> <appana.durga.rao@xilinx.com> wrote:
> > This patch series does some enhancments to the VDMA driver
> > which includes
> > --> Adding support for AXI DMA IP.
> > --> Adding support for AXI CDMA IP.
> > --> Fixing checkpatch warnings.
> >
> > Kedareswara rao Appana (7):
> >   dmaengine: xilinx_vdma: Fix checkpatch.pl warnings
> >   dmaengine: xilinx_vdma: Add quirks support to differentiate differnet
> >     IP cores
> 
> This commitmsg has a typo.
> >   dmaengine: xilinx_vdma: Add Support for Xilinx AXI Direct Memory
> >     Access Engine
> >   dmaengine: xilinx_vdma: Add Support for Xilinx AXI Direct Memory
> >     Access Engine
> 
> These two have the same commit message which is confusing.
> 
> >   dmaengine: xilinx_vdma: Remove unnecessary axi dma device-tree binding
> >     doc
> >   dmaengine: xilinx_vdma: Add Support for Xilinx AXI Central Direct
> >     Memory Access Engine
> >   dmaengine: xilinx_vdma: Add Support for Xilinx AXI Central Direct
> >     Memory Access Engine
> 
> These two have the same commit message which is confusing.

Yes this has been a consistent problem with xilinx patches :(

-- 
~Vinod
