From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 17 Mar 2017 12:12:14 +0100
Subject: [PATCH v2 2/3] arm64: dts: rockchip: add i2s nodes support for
 RK3368 SoCs
In-Reply-To: <1489721564-32203-3-git-send-email-jay.xu@rock-chips.com>
References: <1489721564-32203-1-git-send-email-jay.xu@rock-chips.com>
 <1489721564-32203-3-git-send-email-jay.xu@rock-chips.com>
Message-ID: <1768708.lMtUnYkT1T@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 17. M?rz 2017, 11:32:43 CET schrieb Jianqun Xu:
> I2S of RK3368 SoCs keep same as RK3066 SoCs found on Rockchip,
> add nodes to support them.
> 
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>

applied for 4.12 after moving the clocks property above "dma*"


Thanks
Heiko
