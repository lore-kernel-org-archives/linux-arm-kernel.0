From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Fri, 13 May 2016 04:42:23 +0000
Subject: [PATCH v8 1/2] Documentation: DT: dma: Add Xilinx zynqmp dma
 device tree binding documentation
In-Reply-To: <57347A5C.1080606@metafoo.de>
References: <1463056164-3210-1-git-send-email-appanad@xilinx.com>
 <57347A5C.1080606@metafoo.de>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A581418@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Lars,

	Thanks for the review...

> 
> On 05/12/2016 02:29 PM, Kedareswara rao Appana wrote:
> [...]
> > +- xlnx,include-sg	: Indicates the controller to operate in simple or
> > +			  scatter gather dma mode
> 
> This is also a software runtime configuration parameter.

Hmm I missed it will fix in the next version of the patch.

Regards,
Kedar.
