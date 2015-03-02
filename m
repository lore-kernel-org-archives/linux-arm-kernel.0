From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 2 Mar 2015 04:05:09 +0000 (UTC)
Subject: [PATCH 1/2] ARM: DRA7: hwmod_data: Fix hwmod data for pcie
In-Reply-To: <1424422274-27946-1-git-send-email-kishon@ti.com>
References: <1424422274-27946-1-git-send-email-kishon@ti.com>
Message-ID: <alpine.DEB.2.02.1503020404360.9987@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Feb 2015, Kishon Vijay Abraham I wrote:

> Fixed hwmod data for pcie by having the correct module mode offset.
> Previously this module mode offset was part of pcie PHY which was wrong.
> Now this module mode offset was moved to pcie hwmod and removed the hwmod data
> for pcie phy. While at that renamed pcie_hwmod to pciess_hwmod in order
> to match with the name given in TRM.
> 
> This helps to get rid of the following warning
> "omap_hwmod: pcie1: _wait_target_disable failed"
> 
> [Grygorii.Strashko at linaro.org: Found the issue that actually caused
>  "omap_hwmod: pcie1: _wait_target_disable failed"]
> Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks sent this for v4.0-rc fixes.  Unfortunately I don't have a DRA7xx 
board so can't test.


- Paul
