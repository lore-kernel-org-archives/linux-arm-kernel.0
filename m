From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 21 May 2017 17:27:06 +0800
Subject: [PATCH V2 1/5] pinctrl: imx: fix debug message for
 SHARE_MUX_CONF_REG case
In-Reply-To: <1495177545-23006-2-git-send-email-aisheng.dong@nxp.com>
References: <1495177545-23006-1-git-send-email-aisheng.dong@nxp.com>
 <1495177545-23006-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20170521092704.GJ26102@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 03:05:41PM +0800, Dong Aisheng wrote:
> The original implemented debug message does not work for
> SHARE_MUX_CONF_REG case. This patch fixes it.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Fixes: bf5a530971af ("pinctrl: imx: add VF610 support to imx pinctrl framework")
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>
