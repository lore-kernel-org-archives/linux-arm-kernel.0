From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 11 Mar 2016 12:09:56 +0530
Subject: [PATCH 1/5] dmaengine: sun6i: Fix the access of the IRQ register
In-Reply-To: <f2fb59f3f06600a50ce95886ad25375eafc937da.1457606136.git.moinejf@free.fr>
References: <cover.1457606136.git.moinejf@free.fr>
 <f2fb59f3f06600a50ce95886ad25375eafc937da.1457606136.git.moinejf@free.fr>
Message-ID: <20160311063956.GQ11154@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2016 at 10:15:22AM +0100, Jean-Francois Moine wrote:
> The address of the IRQ register is computed, but its value was not
						^^^^^^^
it's

> used and the register access was done by the channel index instead.
> Then, only the first DMA channel was working.
-- 
~Vinod
