From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 01 Aug 2018 13:57:12 +0200
Subject: [PATCH v2] arm64: dts: rockchip: add support for ROC-RK3399-PC
 board
In-Reply-To: <1532916721-24117-1-git-send-email-djw@t-chip.com.cn>
References: <1532916721-24117-1-git-send-email-djw@t-chip.com.cn>
Message-ID: <3845549.84TLR0FYli@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 30. Juli 2018, 04:12:01 CEST schrieb djw at t-chip.com.cn:
> From: Levin Du <djw@t-chip.com.cn>
> 
> ROC-RK3399-PC is a power efficient 4GB LPDDR4 single board
> computer with USB 3.0 and Gigabit Ethernet in a form factor
> compatible with the Raspberry Pi. It is based on the Rockchip
> RK3399 SoC, powered by the Type-C port.
> 
> The devicetree currently supports peripherals of:
> 
> - Ethernet
> - HDMI
> - SD Card
> - UART2 debug
> - Type-C
> - eMMC
> 
> USB3 in Type-C port currently only works with normal orientation,
> not flip one.
> 
> Signed-off-by: Levin Du <djw@t-chip.com.cn>

applied with Rob's review-tag.

Might still make it into 4.19 but also may have to wait for 4.20


Heiko
