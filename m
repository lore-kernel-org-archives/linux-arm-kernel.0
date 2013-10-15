From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 15 Oct 2013 09:30:47 -0600
Subject: [PATCH] ARM: tegra: add GPIO controller to tegra124.dtsi
In-Reply-To: <1381787167-3011-1-git-send-email-swarren@wwwdotorg.org>
References: <1381787167-3011-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <525D5FA7.20604@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/2013 03:46 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> The Tegra124 GPIO controller is identical to Tegra30, so copy the
> DT node from tegra30.dtsi to tegra124.dtsi.

Applied to Tegra's for-3.13/dt branch.
