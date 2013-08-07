From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 07 Aug 2013 11:00:08 -0600
Subject: [PATCH 3/5] clk: tegra: Fix vde/2d/3d clock src offset
In-Reply-To: <1375874709-10438-3-git-send-email-markz@nvidia.com>
References: <1375874709-10438-1-git-send-email-markz@nvidia.com>
 <1375874709-10438-3-git-send-email-markz@nvidia.com>
Message-ID: <52027D18.5040106@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/2013 05:25 AM, Mark Zhang wrote:
> In Tegra114, vde/gr_2d/gr_3d have 3 bits for clock source selection.
> So change the clock init macro for these clocks from
> "TEGRA_INIT_DATA_INT" to "TEGRA_INIT_DATA_INT8".
> 
> Besides, no one uses "TEGRA_INIT_DATA_INT" after this change, so
> remove this macro.

Patches 3-5 look fine as far as I'm concerned, although I'd like Peter
or Prashant to ack them too.

Patches 3-5,
Acked-by: Stephen Warren <swarren@nvidia.com>
