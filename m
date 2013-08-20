From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 20 Aug 2013 11:47:29 +0300
Subject: [PATCH 3/5] clk: tegra: Fix vde/2d/3d clock src offset
In-Reply-To: <1375874709-10438-3-git-send-email-markz@nvidia.com>
References: <1375874709-10438-1-git-send-email-markz@nvidia.com>
 <1375874709-10438-3-git-send-email-markz@nvidia.com>
Message-ID: <20130820084729.GQ18810@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 07, 2013 at 01:25:07PM +0200, Mark Zhang wrote:
> In Tegra114, vde/gr_2d/gr_3d have 3 bits for clock source selection.
> So change the clock init macro for these clocks from
> "TEGRA_INIT_DATA_INT" to "TEGRA_INIT_DATA_INT8".
> 
> Besides, no one uses "TEGRA_INIT_DATA_INT" after this change, so
> remove this macro.
> 
> Signed-off-by: Mark Zhang <markz@nvidia.com>

Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>
