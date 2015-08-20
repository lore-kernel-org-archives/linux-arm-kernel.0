From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 20 Aug 2015 11:48:31 +0530
Subject: [PATCH v4 1/2] Documentation: dt: Add Xilinx zynqmp dma device
 tree binding documentation
In-Reply-To: <CAGnW=BbjdAUf5SgRXvNNoamhuVjKC4miBUGSiV_s4+Byb0nzog@mail.gmail.com>
References: <1438831173-8761-1-git-send-email-punnaia@xilinx.com>
 <20150820055255.GZ13546@localhost>
 <CAGnW=BbjdAUf5SgRXvNNoamhuVjKC4miBUGSiV_s4+Byb0nzog@mail.gmail.com>
Message-ID: <20150820061831.GB13546@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 11:41:33AM +0530, punnaiah choudary kalluri wrote:
> >> +- interrupts: Should contain DMA channel interrupt
> > channel interrupt or interrupts, former says it is plural
> 
> ZynqMP DMA has single interrupt for each channel So, that is the reason
> i have explicitly mentioned it as interrupt ( not interrupts).
> 
> Please let me know if you still want it to be plural.

The example had multiple values so plural sounds right

-- 
~Vinod
