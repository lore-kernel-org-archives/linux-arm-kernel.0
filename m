From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 10 Dec 2013 17:53:46 +0530
Subject: [PATCH REPOST] dma: tegra: use reset framework
In-Reply-To: <1386102717-21773-1-git-send-email-swarren@wwwdotorg.org>
References: <1386102717-21773-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131210122346.GL29580@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 01:31:57PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Tegra's clock driver now provides an implementation of the common
> reset API (include/linux/reset.h). Use this instead of the old Tegra-
> specific API; that will soon be removed.
Acked-by: Vinod Koul <vinod.koul@intel.com>

--
~Vinod
