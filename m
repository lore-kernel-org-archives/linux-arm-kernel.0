From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Wed, 16 Mar 2016 06:06:34 +0000
Subject: [PATCH 0/7] dmaengine: xilinx_vdma: AXI DMA's enhancments
In-Reply-To: <CAAtXAHe+gbVg866STE_EVGnK6=omjm=GHGsqHGZ3J+uRq5J-Zg@mail.gmail.com>
References: <1458062592-27981-1-git-send-email-appanad@xilinx.com>
 <CAAtXAHe+gbVg866STE_EVGnK6=omjm=GHGsqHGZ3J+uRq5J-Zg@mail.gmail.com>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A56D2A4@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Moritz, 

> -----Original Message-----
> From: Moritz Fischer [mailto:moritz.fischer at ettus.com]
> Sent: Wednesday, March 16, 2016 7:00 AM
> To: Appana Durga Kedareswara Rao
> Cc: Dan Williams; Vinod Koul; Michal Simek; Soren Brinkmann; Appana Durga
> Kedareswara Rao; Laurent Pinchart; Luis de Bethencourt; Anirudha Sarangi;
> dmaengine at vger.kernel.org; linux-arm-kernel; Linux Kernel Mailing List
> Subject: Re: [PATCH 0/7] dmaengine: xilinx_vdma: AXI DMA's enhancments
> 
> Hi,
> 
> On Tue, Mar 15, 2016 at 10:23 AM, Kedareswara rao Appana
> <appana.durga.rao@xilinx.com> wrote:
> > This patch series does some enhancments to the VDMA driver which
> > includes
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

Ok will fix in the next version.

> >   dmaengine: xilinx_vdma: Add Support for Xilinx AXI Direct Memory
> >     Access Engine
> >   dmaengine: xilinx_vdma: Add Support for Xilinx AXI Direct Memory
> >     Access Engine
> 
> These two have the same commit message which is confusing.

Ok will fix in the next version.

> 
> >   dmaengine: xilinx_vdma: Remove unnecessary axi dma device-tree binding
> >     doc
> >   dmaengine: xilinx_vdma: Add Support for Xilinx AXI Central Direct
> >     Memory Access Engine
> >   dmaengine: xilinx_vdma: Add Support for Xilinx AXI Central Direct
> >     Memory Access Engine
> 
> These two have the same commit message which is confusing.

Ok will fix in the next version.

Thanks,
Kedar.

> 
> Cheers,
> 
> Moritz
