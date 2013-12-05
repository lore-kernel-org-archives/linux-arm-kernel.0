From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 05 Dec 2013 16:17:39 -0700
Subject: [PATCH 3/4] ARM: tegra: select PINCTRL_TEGRA124 for Tegra124 SoC
In-Reply-To: <1386241070-4350-4-git-send-email-ldewangan@nvidia.com>
References: <1386241070-4350-1-git-send-email-ldewangan@nvidia.com>
 <1386241070-4350-4-git-send-email-ldewangan@nvidia.com>
Message-ID: <52A10993.2020901@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/2013 03:57 AM, Laxman Dewangan wrote:
> The pincontrol driver for Tegra124 is build through config
> PINCTRL_TEGRA124. Select this config option whenever Tegra124
> SoC is enabled.

I already sent this patch too.
