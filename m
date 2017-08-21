From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 21 Aug 2017 12:05:35 +0200
Subject: [PATCH v2] arm64: dts: rockchip: add rk805 node for rk3328-evb
In-Reply-To: <1502244224-11999-2-git-send-email-chenjh@rock-chips.com>
References: <1502244224-11999-1-git-send-email-chenjh@rock-chips.com>
 <1502244224-11999-2-git-send-email-chenjh@rock-chips.com>
Message-ID: <1567365.GLZbXPjLJs@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 9. August 2017, 10:03:44 CEST schrieb Joseph Chen:
> RK805 consists of 4 DCDCs, 3 LDOs. It's different from RK808
> and RK818 that there are 2 output only GPIOs, we should add
> properties "gpio-controller" and "gpio-cells = <2>".
> 
> Signed-off-by: Joseph Chen <chenjh@rock-chips.com>

adapted to the meanwhile changed rk3328-evb.dts and then
applied for 4.14


Thanks
Heiko
