From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 3 May 2016 12:28:12 +0530
Subject: [PATCH v4 0/5] Add XOR engine support to Armada 3700 SoC (ARM64)
In-Reply-To: <1461916149-30900-1-git-send-email-gregory.clement@free-electrons.com>
References: <1461916149-30900-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20160503065811.GP2274@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2016 at 09:49:04AM +0200, Gregory CLEMENT wrote:
> Hi,
> 
> This series adds the support of the Marvell XOR engine to the Armada
> 3700 SoC. As this SoC is an ARM64 one, then the code has been fixed to
> support the 64 bits platform.
> 
> The initialization for the Armada 3700 is different from the other
> SoCs, so in order to support it, a new way of handling the different
> family have been added.
> 
> Once the dmaengine part will be approved, I will apply the dts part
> in the mvebu/dt64 tree.
> 
> In this fourth series I took into account the remarks from Vinoud, I
> also updated the dts patch that I will apply on my tree.

Applied, 1 thru 4.

-- 
~Vinod
