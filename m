From: caesar.upstream@gmail.com (Caesar Wang)
Date: Mon, 28 Sep 2015 10:09:49 +0800
Subject: [PATCH 0/3] mailbox: rockchip: Add mailbox driver for Rockchip
 platform
In-Reply-To: <1442228798-15191-1-git-send-email-wxt@rock-chips.com>
References: <1442228798-15191-1-git-send-email-wxt@rock-chips.com>
Message-ID: <5608A16D.4090109@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jassi,

Friendly Ping!

Could you review this series patchs if you have free time?


? 2015?09?14? 19:06, Caesar Wang ??:
> Mailbox is used by the Rockchip CPU cores to communicate
> requests to MCU processorm.
>
> This driver is found on RK3368 SoCs.
>
> The Mailbox module is a simple APB peripheral that allows both
> the Cortex-A53 MCU system to communicate by writing operation to
> generate interrupt.
> The registers are accessible by both CPU via APB interface.
>
> Tested on RK3368 SDK board.
>
>
>
> Caesar Wang (3):
>    dt-bindings: Add document of Rockchip mailbox
>    mailbox: rockchip: Add Rockchip mailbox driver
>    ARM64: dts: rk3368: Add mailbox device nodes
>
>   .../bindings/mailbox/rockchip-mailbox.txt          |  33 +++
>   arch/arm64/boot/dts/rockchip/rk3368.dtsi           |  13 +
>   drivers/mailbox/Kconfig                            |   9 +
>   drivers/mailbox/Makefile                           |   2 +
>   drivers/mailbox/rockchip-mailbox.c                 | 317 +++++++++++++++++++++
>   5 files changed, 374 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/mailbox/rockchip-mailbox.txt
>   create mode 100644 drivers/mailbox/rockchip-mailbox.c
>

-- 
Thanks,
Caesar
