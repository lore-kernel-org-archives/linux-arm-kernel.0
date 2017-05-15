From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 15 May 2017 20:05:56 +0800
Subject: [PATCH 5/5] pinctrl: imx: fix debug message for
 SHARE_MUX_CONF_REG case
In-Reply-To: <1494592686-30967-7-git-send-email-aisheng.dong@nxp.com>
References: <1494592686-30967-1-git-send-email-aisheng.dong@nxp.com>
 <1494592686-30967-7-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20170515120555.GR8471@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 12, 2017 at 08:38:06PM +0800, Dong Aisheng wrote:
> The original implemented debug message does not work for
> SHARE_MUX_CONF_REG case. This patch fixes it.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Fixes: bf5a530971af ("pinctrl: imx: add VF610 support to imx pinctrl framework")
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Fixes should go first in a patch series.

Shawn
