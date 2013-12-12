From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 12 Dec 2013 13:20:51 -0700
Subject: [PATCH] ARM: tegra: add default pinctrl nodes for Venice2
In-Reply-To: <1386585231-1183-1-git-send-email-ldewangan@nvidia.com>
References: <1386585231-1183-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <52AA1AA3.70303@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/2013 03:33 AM, Laxman Dewangan wrote:
> Add the default pinmux configuration for the Tegra124 based
> Venice2 platform.

Applied to Tegra's for-3.14/dt branch. I removed all the blank lines
between the nodes for consistency with the pinctrl state definitions in
other Tegra DT files.
