From: info@lategoodbye.de (Stefan Wahren)
Date: Tue, 01 Apr 2014 19:28:33 +0200
Subject: [PATCH v2 0/4] arm: mxs: dts: small fixes for I2SE's duckbills
In-Reply-To: <1395960690-19531-1-git-send-email-mhei@heimpold.de>
References: <1395960690-19531-1-git-send-email-mhei@heimpold.de>
Message-ID: <533AF741.4080402@lategoodbye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 27.03.2014 23:51, schrieb Michael Heimpold:
> This series fixes two issues with the DT file: first, it frees up
> some GPIOs which are mis-used by MMC interface, and second, it
> fixes the GPIO used to reset the ethernet phy.
>
> While at it, use symbolic names for LED definitions.
>
> Changes in v2:
>   - add missing patch for imx28.dtsi to include gpio.h
>
>
> Michael Heimpold (4):
>    arm: mxs: dt: imx28-duckbill: fix mmc settings
>    arm: mxs: dt: imx28-duckbill: fix phy reset gpio
>    arm: mxs: dt: imx28: include gpio.h to allow use of symbolic names
>    arm: mxs: dt: imx28-duckbill: use symbolic names from gpio.h
>
>   arch/arm/boot/dts/imx28-duckbill.dts |   12 ++++++------
>   arch/arm/boot/dts/imx28.dtsi         |    1 +
>   2 files changed, 7 insertions(+), 6 deletions(-)
>

They all look good to me.

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

BR Stefan Wahren
