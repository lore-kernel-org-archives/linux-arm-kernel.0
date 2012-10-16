From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 16 Oct 2012 11:30:08 -0600
Subject: [PATCH 0/2] ARM: tegra: bring back tegra_timer clock
In-Reply-To: <1350382116-18024-1-git-send-email-sivaramn@nvidia.com>
References: <1350382116-18024-1-git-send-email-sivaramn@nvidia.com>
Message-ID: <507D99A0.1030701@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/16/2012 04:08 AM, Sivaram Nair wrote:
> This patchset fixes a bug introduced by commit
> 20f4665831cec65d6e5d33587bba28ffa536b91d by bringing back the
> tegra_timer clock.  The above commit caused tegra_init_timer() failing
> to get the clk reference.
> 
> The first patch renames the existing tegra_timer object to
> tegra_sys_timer and the second patch adds previously-removed tegra_timer
> clock object.

Thanks. The series applied to Tegra's for-3.7/fixes-for-rc2 branch.
Sorry for the regression.
