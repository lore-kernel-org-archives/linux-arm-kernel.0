From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Mon, 5 Oct 2015 13:50:07 +0000
Subject: [PATCH v6 2/2] dmaengine: Add Xilinx AXI Central Direct Memory
 Access Engine driver support
In-Reply-To: <20151005133907.GA13501@vkoul-mobl.iind.intel.com>
References: <1441629198-17663-1-git-send-email-appanad@xilinx.com>
 <20151005133907.GA13501@vkoul-mobl.iind.intel.com>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A4EC176@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

	
> -----Original Message-----
> From: Vinod Koul [mailto:vinod.koul at intel.com]
> Sent: Monday, October 05, 2015 7:09 PM
> To: Appana Durga Kedareswara Rao
> Cc: dan.j.williams at intel.com; Anirudha Sarangi; Michal Simek; Soren Brinkmann;
> Appana Durga Kedareswara Rao; dmaengine at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v6 2/2] dmaengine: Add Xilinx AXI Central Direct Memory
> Access Engine driver support
> 
> On Mon, Sep 07, 2015 at 06:03:18PM +0530, Kedareswara rao Appana wrote:
> > This is the driver for the AXI Central Direct Memory Access (AXI
> > CDMA) core, which is a soft Xilinx IP core that provides
> > high-bandwidth Direct Memory Access (DMA) between a memory-mapped
> > source address and a memory-mapped destination address.
> 
> Where is the 1/2 here ? I have only this one in my mails..

You are there in the 1/2 not the dmaengine at vger.kernel.org.

./scripts/get_maintainer.pl -f Documentation/devicetree/bindings/dma/xilinx/xilinx_cdma.txt
Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Pawel Moll <pawel.moll@arm.com> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Ian Campbell <ijc+devicetree@hellion.org.uk> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Kumar Gala <galak@codeaurora.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Michal Simek <michal.simek@xilinx.com> (supporter:ARM/ZYNQ ARCHITECTURE)
"S?ren Brinkmann" <soren.brinkmann@xilinx.com> (reviewer)
Kedareswara rao Appana <appanad@xilinx.com> (commit_signer:1/1=100%,authored:1/1=100%,added_lines:54/54=100%)
devicetree at vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
linux-arm-kernel at lists.infradead.org (moderated list:ARM/ZYNQ ARCHITECTURE)
linux-kernel at vger.kernel.org (open list)

If you want me to resend the patch will resend

Regards,
Kedar.

> 
> --
> ~Vinod
