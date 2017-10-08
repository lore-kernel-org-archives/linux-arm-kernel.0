From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 8 Oct 2017 14:46:27 +0530
Subject: [PATCH v5 2/4] dmaengine: Add STM32 MDMA driver
In-Reply-To: <1506613003-28376-3-git-send-email-pierre-yves.mordret@st.com>
References: <1506613003-28376-1-git-send-email-pierre-yves.mordret@st.com>
 <1506613003-28376-3-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <20171008091627.GJ30097@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 28, 2017 at 05:36:41PM +0200, Pierre-Yves MORDRET wrote:
> This patch adds the driver for the STM32 MDMA controller.
> 
> Master Direct memory access (MDMA) is used in order to provide high-speed
> data transfer between memory and memory or between peripherals and memory.
> 
> MDMA controller provides a master AXI interface for main memory and
> peripheral registers access (system access port) and a master AHB
> interface only for Cortex-M7 TCM memory access (TCM access port).
> 
> MDMA works in conjunction with the standard DMA controllers (DMA1 or DMA2).
> It offers up to 64 channels, each dedicated to managing memory access
> requests from one of the DMA stream memory buffer or other peripherals
> (w/ integrated FIFO).

Applied, thanks

-- 
~Vinod
