From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 13 Jul 2017 16:46:02 +0800
Subject: [PATCH V4 7/7] pinctrl: pinctrl-imx7ulp: add gpio_set_direction
 support
In-Reply-To: <1498046395-30001-8-git-send-email-aisheng.dong@nxp.com>
References: <1498046395-30001-1-git-send-email-aisheng.dong@nxp.com>
 <1498046395-30001-8-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20170713084601.GW3172@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 07:59:55PM +0800, Dong Aisheng wrote:
> Add gpio_set_direction support. This makes the driver support
> GPIO input/output dynamically change from userspace.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Fugang Duan <fugang.duan@nxp.com>
> Cc: Bai Ping <ping.bai@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>
