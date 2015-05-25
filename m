From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 25 May 2015 14:47:00 +0800
Subject: [PATCH v4 0/6] Change snvs rtc and poweroff to use syscon add
 pwrkey driver
In-Reply-To: <1432305399-30571-1-git-send-email-Frank.Li@freescale.com>
References: <1432305399-30571-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20150525064659.GH3264@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 22, 2015 at 10:36:33PM +0800, Frank.Li at freescale.com wrote:
> Frank Li (5):
>   rtc: arm: imx: snvs: change use syscon to access register
>   Document: dt: fsl: snvs: change support syscon
>   arm: dts: imx: update snvs to use syscon access register
>   document: devicetree: input: imx: i.mx snvs power device tree bindings
>   arm: dts: imx6sx: enable snvs power key
> 
> Robin Gong (1):
>   input: keyboard: imx: add snvs power key driver

For patch subject prefix, I suggest you use some help from 'git log' to
find out what the best practice is for the files you are patching.

Shawn
