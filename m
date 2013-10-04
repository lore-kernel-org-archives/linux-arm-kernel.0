From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 04 Oct 2013 11:00:38 -0600
Subject: [PATCH 1/2] clk: tegra114: Rename gr_2d/gr_3d to gr2d/gr3d
In-Reply-To: <1380748361-32459-1-git-send-email-treding@nvidia.com>
References: <1380748361-32459-1-git-send-email-treding@nvidia.com>
Message-ID: <524EF436.4000704@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/2013 03:12 PM, Thierry Reding wrote:
> These clocks were named gr2d and gr3d on Tegra20 and Tegra30, so use the
> same names on Tegra114 for consistency.

The series,
Acked-by: Stephen Warren <swarren@nvidia.com>

Although I wonder if there will be merge conflicts with Peter's "clk:
tegra: replace enum tegra114_clk by binding header"?
