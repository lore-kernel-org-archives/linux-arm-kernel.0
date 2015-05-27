From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 27 May 2015 20:10:53 +0800
Subject: [PATCH v5 0/6] Change snvs rtc and poweroff to use syscon add
 pwrkey driver
In-Reply-To: <1432657562-5592-1-git-send-email-Frank.Li@freescale.com>
References: <1432657562-5592-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20150527121052.GH16165@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 27, 2015 at 12:25:56AM +0800, Frank.Li at freescale.com wrote:
> Frank Li (5):
>   rtc: arm: imx: snvs: change use syscon to access register
>   Document: dt: fsl: snvs: change support syscon
>   ARM: dts: imx: update snvs to use syscon access register
>   Document: devicetree: input: imx: i.mx snvs power device tree bindings
>   ARM: dts: imx6sx: enable snvs power key
> 
> Robin Gong (1):
>   input: keyboard: imx: add snvs power key driver

The series looks fine to me now.  But I can only apply those two dts
patches after the driver and binding parts get landed on mainline.
Hopefully, you can get them in during the coming merge window through
subsystem trees, so that I can pick up dts part after v4.2-rc1 comes
out.

Shawn
