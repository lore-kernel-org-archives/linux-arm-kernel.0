From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 29 Feb 2016 11:04:25 +0800
Subject: [PATCH 09/50] pinctrl: imx: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-10-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
 <1456319775-3216-10-git-send-email-ldewangan@nvidia.com>
Message-ID: <20160229030425.GQ22051@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2016 at 06:45:34PM +0530, Laxman Dewangan wrote:
> Use devm_pinctrl_register() for pin control registration and remove
> need of .remove callback.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Shawn Guo <shawnguo@kernel.org>

Acked-by: Shawn Guo <shawnguo@kernel.org>
