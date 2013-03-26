From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 26 Mar 2013 14:54:04 -0600
Subject: [PATCH] ARM: tegra: enable Tegra114 in defconfig,
 rebuild defconfig
In-Reply-To: <1364330887-6039-1-git-send-email-swarren@wwwdotorg.org>
References: <1364330887-6039-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <51520AEC.4000207@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/26/2013 02:48 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> This enables CONFIG_ARCH_TEGRA_114_SOC, and rebuilds tegra_defconfig
> based on v3.9-rc1. Hence, some other changes are includes, due to moved,
> removed, or now-default options.

I have squashed this into Tegra's for-3.10/defconfig branch.
