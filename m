From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Mar 2014 23:13:49 +0100
Subject: [PATCH] ARM: tegra: fix board DT pinmux setup
In-Reply-To: <1395360361-17130-1-git-send-email-swarren@wwwdotorg.org>
References: <1395360361-17130-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201403262313.49387.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 March 2014, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Neither Tegra114 nor Tegra124 allow "low power mode" to be configured
> on SDIO1 or SDIO3 drive groups. Remove the attempt to configure that
> option from the Dalmore and Venice2 DTs.
> 
> The Venice2 DT contained duplicate configurations for most sdmmc1_*
> pins. Remove the duplicate pins from one of the nodes, and fix the
> configuration since the remaining clk pin is output-only.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Applied to fixes-non-critical.

Thanks,

	ARnd
