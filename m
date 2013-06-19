From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 19 Jun 2013 16:51:30 +0800
Subject: [PATCH v2 2/2] i2c: imx: Add Vybrid VF610 I2C controller support
In-Reply-To: <1371545327-12481-1-git-send-email-b35083@freescale.com>
References: <1371545327-12481-1-git-send-email-b35083@freescale.com>
Message-ID: <20130619085127.GB3405@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 04:48:47PM +0800, Jingchang Lu wrote:
>   Add Freescale Vybrid VF610 I2C controller support to
> imx I2C driver framework.
>   Some operation is different from imx I2C controller.
> The register offset, the i2c clock divider value table,
> the module enabling(I2CR_IEN) which is just invert with imx,
> and the interrupt flag(I2SR) clearing opcode is w1c on VF610
> but w0c on imx.
> 
> Signed-off-by: Jason Jin <Jason.jin@freescale.com>
> Signed-off-by: Xiaochun Li <b41219@freescale.com>
> Signed-off-by: Jingchang Lu <b35083@freescale.com>

Tested-by: Shawn Guo <shawn.guo@linaro.org>
