From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 19 Aug 2017 01:07:43 +0200
Subject: [PATCH] arm64: dts: rockchip: Fix wrong rt5514 dmic delay
 property for Gru
In-Reply-To: <20170818144808.27869-1-jeffy.chen@rock-chips.com>
References: <20170818144808.27869-1-jeffy.chen@rock-chips.com>
Message-ID: <2229813.qu8LfHYij4@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 18. August 2017, 22:48:08 CEST schrieb Jeffy Chen:
> According to rt5514 dt-binding, it should be "realtek,dmic-init-delay-ms".
> 
> Fixes: 48f4d9796d99 (arm64: dts: rockchip: add Gru/Kevin DTS)
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

applied for 4.14


Thanks
Heiko
