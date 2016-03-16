From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 16 Mar 2016 08:43:51 +0530
Subject: [PATCH 2/7] dmaengine: xilinx_vdma: Add quirks support to
 differentiate differnet IP cores
In-Reply-To: <1458062592-27981-3-git-send-email-appanad@xilinx.com>
References: <1458062592-27981-1-git-send-email-appanad@xilinx.com>
 <1458062592-27981-3-git-send-email-appanad@xilinx.com>
Message-ID: <20160316031350.GN13211@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 15, 2016 at 10:53:07PM +0530, Kedareswara rao Appana wrote:
> This patch adds quirks support in the driver to differentiate differnet IP cores.

Wouldn't it help to explain why quirks are needed for these cores in
changelog?

Also limit your changelogs properly. Am sure checkpatch would have warned
you!

-- 
~Vinod
