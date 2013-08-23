From: marex@denx.de (Marek Vasut)
Date: Fri, 23 Aug 2013 12:41:46 +0200
Subject: [PATCH 1/1]  ARM: dts: imx28-evk: Add pinctrl for USB OTG ID pin
In-Reply-To: <1377237390-15983-1-git-send-email-peter.chen@freescale.com>
References: <1377237390-15983-1-git-send-email-peter.chen@freescale.com>
Message-ID: <201308231241.47017.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Peter Chen,

> After that, the dual-role switch can be used at imx28-evk.
> 
> Due to hardware limitations, it needs to switch VDD 5V
> SOURCE SELECT to "USB 5V" if the user wants to use OTG
> dual-role switch function. it needs to switch VDD 5V
> SOURCE SELECT to "WALL 5V" if the user wants to Host 1.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  arch/arm/boot/dts/imx28-evk.dts |    2 ++
>  arch/arm/boot/dts/imx28.dtsi    |   11 +++++++++++
>  2 files changed, 13 insertions(+), 0 deletions(-)

Thanks.

Acked-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
