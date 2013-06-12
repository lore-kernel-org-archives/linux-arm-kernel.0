From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 12 Jun 2013 09:36:11 -0600
Subject: [PATCH V4 1/4] ARM: tegra30: clocks: Fix pciex clock registration
In-Reply-To: <1371021223-6709-1-git-send-email-jagarwal@nvidia.com>
References: <1371021223-6709-1-git-send-email-jagarwal@nvidia.com>
Message-ID: <51B8956B.8020704@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2013 01:13 AM, Jay Agarwal wrote:
> Registering pciex as peripheral clock instead of fixed clock
> as tegra_perih_reset_assert(deassert) api of this clock api
> gives warning and ultimately does not succeed to assert(deassert)
> 
> Signed-off-by: Jay Agarwal <jagarwal@nvidia.com>
> ---
> Patch is based on remotes/gitorious_thierryreding_linux/tegra/next and should be applied on top of this.

In this case, it would make more sense to apply this to the clock tree,
since it's a standalone bug-fix.

Acked-by: Stephen Warren <swarren@nvidia.com>
