From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Thu, 12 Jan 2017 14:19:57 +0000
Subject: [PATCH v5 2/3] dmaeninge: xilinx_dma: Fix bug in multiple frame
 stores scenario in vdma
In-Reply-To: <20170110062620.GZ3573@localhost>
References: <1483771530-8545-1-git-send-email-appanad@xilinx.com>
 <1483771530-8545-3-git-send-email-appanad@xilinx.com>
 <20170110062620.GZ3573@localhost>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A666301@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

	Thanks for the review...  

> 
> On Sat, Jan 07, 2017 at 12:15:29PM +0530, Kedareswara rao Appana wrote:
> > When VDMA is configured for more than one frame in the h/w for example
> > h/w is configured for n number of frames and user Submits n number of
> > frames and triggered the DMA using issue_pending API.
> 
> title case in middle if sentence, no commas, can you make it easier to read
> please..

Ok sure will fix commit message in the next version.

> 
> > In the current driver flow we are submitting one frame at a time but
> > we should submit all the n number of frames at one time as the h/w Is
> > configured for n number of frames.
> 
> s/Is/is

Ok sure will fix in the next version....

Regards,
Kedar.
