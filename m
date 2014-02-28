From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Feb 2014 21:39:39 +0100
Subject: [PATCH] ARM: tegra: add LED options back into tegra_defconfig
In-Reply-To: <1392932240-14480-1-git-send-email-swarren@wwwdotorg.org>
References: <1392932240-14480-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201402282139.40122.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 February 2014, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> The last time tegra_defconfig was rebuilt, various LEDs options were
> somehow selected by other options, and hence their entries in
> tegra_defconfig were removed by "make savedefconfig". However, for some
> reason this is no longer happening, so we need to add the entries back
> into tegra_defconfig so the they are enabled in .config.
> 
> Fixes: db079b1811d1 ("ARM: tegra: rebuild tegra_defconfig to add DEBUG_FS)"
> Reported-by: Marc Dietrich <marvin24@gmx.de>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Another fix for 3.14.

Applied to fixes branch.

	Arnd
