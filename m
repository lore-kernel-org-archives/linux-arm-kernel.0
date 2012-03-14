From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 14 Mar 2012 07:01:06 +0100
Subject: [PATCH v1 0/5] dt: add basic imx28 support
In-Reply-To: <1331628428-24017-1-git-send-email-b29396@freescale.com>
References: <1331628428-24017-1-git-send-email-b29396@freescale.com>
Message-ID: <201203140701.07111.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Dong Aisheng,

> This patch series adds basic imx28 dt support including fec, mmc and dma.
> 
> Tested on mx28evk.
> 
> TODO:
> Convert the remaining devices to support dt.
> mxs-auart, mxs-gpio, i2c, flexcan, saif, rtc, pwm, fb.
> 
> Dong Aisheng (5):
>   ARM: imx28: add basic dt support
>   mmc: mxs-mmc: add dt probe support
>   ARM: imx28evk: add mmc dt support
>   dma: mxs-dma: add dt probe support
>   ARM: mxs: add mxs dma dt support
> 
Can you keep me in Cc on new versions of these patches? Thanks!

Best regards,
Marek Vasut
