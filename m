From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 20 Aug 2012 11:15:55 -0600
Subject: [PATCH] ARM: tegra: remove duplicate select USE_OF
In-Reply-To: <1345477283-26000-1-git-send-email-swarren@wwwdotorg.org>
References: <1345477283-26000-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <503270CB.4090700@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/2012 09:41 AM, Stephen Warren wrote:
> ARCH_TEGRA (arch/arm/Kconfig) now selects USE_OF, so there's not need
> for ARCH_TEGRA_3x_SOC to do so too.

Applied to Tegra's for-3.7/fixes branch.
