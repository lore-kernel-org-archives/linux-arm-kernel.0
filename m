From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 03 May 2012 11:43:39 -0600
Subject: [PATCHv3 2/4] ARM: tegra: Add SMMU enabler in AHB
In-Reply-To: <1336061147-10245-2-git-send-email-hdoyu@nvidia.com>
References: <1336061147-10245-1-git-send-email-hdoyu@nvidia.com>
 <1336061147-10245-2-git-send-email-hdoyu@nvidia.com>
Message-ID: <4FA2C3CB.60204@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/2012 10:05 AM, Hiroshi DOYU wrote:
> Add extern func, "tegra_ahb_enable_smmu()" to inform AHB that SMMU is
> ready.
> 
> Signed-off-by: Hiroshi DOYU <hdoyu@nvidia.com>
> Cc: Felipe Balbi <balbi@ti.com>

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
