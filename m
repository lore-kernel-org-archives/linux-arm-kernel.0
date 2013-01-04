From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 04 Jan 2013 09:25:30 -0700
Subject: [PATCH 2/2] clk: tegra30: Convert clk out to composite clk
In-Reply-To: <1357278706-28149-2-git-send-email-pgaikwad@nvidia.com>
References: <1357278706-28149-1-git-send-email-pgaikwad@nvidia.com>
 <1357278706-28149-2-git-send-email-pgaikwad@nvidia.com>
Message-ID: <50E7027A.1090102@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/2013 10:51 PM, Prashant Gaikwad wrote:
> Convert clk out to composite clock type which removes
> the mux clock.
> 
> Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
> ---
> This patch is rebased on ccf-rework for Tegra patch series. It is just to show
> how clk-composite can be used, not to be merged. If patch 1 is accepted then
> I would like to merge this patch to ccf-rework series.

Just so I'm clear, is the intent that patch 1 of this series gets
reviewed/accepted, and then you'll repost an updated version of the
Tegra CCF rework series that relies on patch 1? If so, patch 1 would
need to be either taken through the Tegra tree, or put into a separate
branch in the clock tree, so the Tegra tree can merge it as a dependency
of the Tegra CCF rework branch.
