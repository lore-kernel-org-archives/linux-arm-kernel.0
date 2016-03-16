From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Tue, 15 Mar 2016 18:29:38 -0700
Subject: [PATCH 0/7] dmaengine: xilinx_vdma: AXI DMA's enhancments
In-Reply-To: <1458062592-27981-1-git-send-email-appanad@xilinx.com>
References: <1458062592-27981-1-git-send-email-appanad@xilinx.com>
Message-ID: <CAAtXAHe+gbVg866STE_EVGnK6=omjm=GHGsqHGZ3J+uRq5J-Zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Mar 15, 2016 at 10:23 AM, Kedareswara rao Appana
<appana.durga.rao@xilinx.com> wrote:
> This patch series does some enhancments to the VDMA driver
> which includes
> --> Adding support for AXI DMA IP.
> --> Adding support for AXI CDMA IP.
> --> Fixing checkpatch warnings.
>
> Kedareswara rao Appana (7):
>   dmaengine: xilinx_vdma: Fix checkpatch.pl warnings
>   dmaengine: xilinx_vdma: Add quirks support to differentiate differnet
>     IP cores

This commitmsg has a typo.
>   dmaengine: xilinx_vdma: Add Support for Xilinx AXI Direct Memory
>     Access Engine
>   dmaengine: xilinx_vdma: Add Support for Xilinx AXI Direct Memory
>     Access Engine

These two have the same commit message which is confusing.

>   dmaengine: xilinx_vdma: Remove unnecessary axi dma device-tree binding
>     doc
>   dmaengine: xilinx_vdma: Add Support for Xilinx AXI Central Direct
>     Memory Access Engine
>   dmaengine: xilinx_vdma: Add Support for Xilinx AXI Central Direct
>     Memory Access Engine

These two have the same commit message which is confusing.

Cheers,

Moritz
