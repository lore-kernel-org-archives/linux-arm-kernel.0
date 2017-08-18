From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 19 Aug 2017 01:17:26 +0200
Subject: [PATCH] arm64: dts: rockchip: Assign mic irq to correct device
 for Gru
In-Reply-To: <20170816092432.23991-1-jeffy.chen@rock-chips.com>
References: <20170816092432.23991-1-jeffy.chen@rock-chips.com>
Message-ID: <1737976.DtYLZJGtdQ@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 16. August 2017, 17:24:32 CEST schrieb Jeffy Chen:
> Currently we are assigning mic irq to rt5514 i2c driver, which is wrong.
> Assign it to rt5514 spi driver instead.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

applied for 4.14


Thanks
Heiko
