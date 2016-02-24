From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 24 Feb 2016 09:44:08 -0700
Subject: [PATCH 29/50] pinctrl: tegra: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-30-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
 <1456319775-3216-30-git-send-email-ldewangan@nvidia.com>
Message-ID: <56CDDDD8.8040304@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/24/2016 06:15 AM, Laxman Dewangan wrote:
> Use devm_pinctrl_register() for pin control registration and remove
> need of .remove callback.

Acked-by: Stephen Warren <swarren@nvidia.com>

Any chance you could send a patch to soc-to-kernel-pinctrl-driver.py in 
git://github.com/NVIDIA/tegra-pinmux-scripts.git for this too?
