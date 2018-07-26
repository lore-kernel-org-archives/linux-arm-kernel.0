From: ezequiel@collabora.com (Ezequiel Garcia)
Date: Thu, 26 Jul 2018 10:41:58 -0300
Subject: [PATCH v1] arm64: dts: rockchip: add support for ROC-RK3399-PC
 board
In-Reply-To: <1532589205-10153-1-git-send-email-djw@t-chip.com.cn>
References: <1532589205-10153-1-git-send-email-djw@t-chip.com.cn>
Message-ID: <cd4706970b40b49373ad169e3f9651f29508194a.camel@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-07-26 at 15:13 +0800, djw at t-chip.com.cn wrote:
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
> - TYPE-C

Hi Levin,

Last time I tried to make the mainline fusb driver work, it really didn't.
Is USB 3.0 Type-C actually working with mainline on this board?

Thanks!
Eze
