From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 19 Sep 2013 12:25:12 -0600
Subject: [PATCH 1/2] ARM: tegra: enable PALMAS_PINCTRL config
In-Reply-To: <1379509642-19227-1-git-send-email-ldewangan@nvidia.com>
References: <1379509642-19227-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <523B4188.9020804@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2013 07:07 AM, Laxman Dewangan wrote:
> PALMAS PMIC is used on Dalmore platform. Enable the pincontrol
> driver for Palmas to configure pins of Palmas on desired state.

I applied the series. Patch 1 (squash in)to Tegra's for-3.13/defconfig,
patch 2 to Tegra's for-3.13/dt branch.
