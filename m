From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 03 Jan 2013 09:50:53 -0700
Subject: [PATCH] ARM: tegra: fix Kconfig warnings when !SMP
In-Reply-To: <1357162455-24043-1-git-send-email-swarren@wwwdotorg.org>
References: <1357162455-24043-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <50E5B6ED.1040403@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/2013 02:34 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Fix:
> 
> warning: (ARCH_TEGRA_2x_SOC) selects ARM_ERRATA_754327 which has unmet direct dependencies (CPU_V7 && SMP)
> warning: (ARCH_TEGRA_2x_SOC) selects ARM_ERRATA_742230 which has unmet direct dependencies (CPU_V7 && SMP)
> 
> by selecting options only if SMP.

Applied to Tegra's for-3.9/cleanup branch.
