From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 18 Jul 2013 11:00:09 -0600
Subject: [PATCH] memory: tegra: depend on ARCH_TEGRA, not ARCH_TEGRA_*
In-Reply-To: <1374013147-4775-1-git-send-email-swarren@wwwdotorg.org>
References: <1374013147-4775-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <51E81F19.2070402@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/2013 04:19 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> I'm planning to remove CONFIG_ARCH_TEGRA_*_SOC, leaving just ARCH_TEGRA.
> This will reduce the number of configurations that need to be supported
> by core Tegra code, e.g. CPU idle, hotplug. As a precursor, we need to
> update Kconfig for all Tegra drivers not to reference ARCH_TEGRA_*_SOC.

I'd like to defer actually applying this patch. There is some discussion
(in the thread for the equivalent ASoC patches) re: the best way to
handle the ARCH_TEGRA_*_SOC Kconfig options which might affect this
patch. Any review comment is still appreciated.
