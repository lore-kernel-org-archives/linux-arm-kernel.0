From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 18 Dec 2017 10:49:31 +0530
Subject: [PATCH v7 0/6] dmaengine: xilinx_dma: Bug fixes
In-Reply-To: <1512624067-13554-1-git-send-email-appanad@xilinx.com>
References: <1512624067-13554-1-git-send-email-appanad@xilinx.com>
Message-ID: <20171218051931.GO18649@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 07, 2017 at 10:51:01AM +0530, Kedareswara rao Appana wrote:
> This patch series fixes below bugs in DMA and VDMA IP's
> ---> Added channel idle checks in the driver before submitting the buffer descriptor to h/w.
> ---> Fixes bug in Multi frame sotres handling in VDMA
> ---> Fixes issues w.r.to multi frame descriptors submit with AXI DMA S2MM(recv) Side.
> ---> Fixed kernel doc warnings in the driver.
> ---> Fixed checkpatch errors in the driver.

Applied after applying this to fix typo. You seriously need a decent spell
checker in your editor

-       /* This variable enusres that descripotrs are not
-        * Submited when dma engine is in progress. This variable is
-        * Added to avoid pollling for a bit in the status register to
+       /* This variable ensures that descriptors are not
+        * Submitted when dma engine is in progress. This variable is
+        * Added to avoid polling for a bit in the status register to

-- 
~Vinod
