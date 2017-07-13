From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 13 Jul 2017 16:43:42 +0800
Subject: [PATCH V4 3/7] pinctrl: imx: switch to use the generic pinmux
 property
In-Reply-To: <1498046395-30001-4-git-send-email-aisheng.dong@nxp.com>
References: <1498046395-30001-1-git-send-email-aisheng.dong@nxp.com>
 <1498046395-30001-4-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20170713084341.GV3172@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 07:59:51PM +0800, Dong Aisheng wrote:
> The generic pinmux property seems to be more suitable for IMX.
> So we change to use 'pinmux' instead of 'pins'.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Bai Ping <ping.bai@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>
