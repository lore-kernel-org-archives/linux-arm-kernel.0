From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 24 Feb 2016 09:41:42 -0700
Subject: [PATCH 30/50] pinctrl: tegra-xusb: Use devm_pinctrl_register()
 for pinctrl registration
In-Reply-To: <1456319775-3216-31-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
 <1456319775-3216-31-git-send-email-ldewangan@nvidia.com>
Message-ID: <56CDDD46.1060907@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/24/2016 06:15 AM, Laxman Dewangan wrote:
> Use devm_pinctrl_register() for pin control registration and clean
> the error path.

Acked-by: Stephen Warren <swarren@nvidia.com>
