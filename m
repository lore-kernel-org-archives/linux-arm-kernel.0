From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 08 Aug 2013 11:48:34 -0600
Subject: [PATCH] ARM: tegra: unify Tegra's Kconfig a bit more
In-Reply-To: <1375907952-24746-1-git-send-email-swarren@wwwdotorg.org>
References: <1375907952-24746-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <5203D9F2.9070401@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/2013 02:39 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Move all common select clauses from ARCH_TEGRA_*_SOC to ARCH_TEGRA to
> eliminate duplication. The USB-related selects all should have been
> common too, but were missing from Tegra114 previously. Move these to
> ARCH_TEGRA too. The latter fixes a build break when only Tegra114
> support was enabled, but not Tegra20 or Tegra30 support.

I've applied this to Tegra's for-3.12/soc branch.
