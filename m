From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 01 Mar 2018 11:57:37 +0100
Subject: [PATCH] mmc: dw_mmc-rockchip: correct property names in debug
In-Reply-To: <20180301103625.7285-1-john@metanate.com>
References: <20180301103625.7285-1-john@metanate.com>
Message-ID: <2057001.Y3n4QWSv6R@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 1. M?rz 2018, 11:36:25 CET schrieb John Keeping:
> Following up the device tree fixed in commits e78c637127ee ("ARM: dts:
> rockchip: Fix DWMMC clocks") and ca9eee95a2de ("arm64: dts: rockchip:
> Fix DWMMC clocks", 2018-02-15), avoid confusion by using the correct
> property name in the debug output if clocks are not found.
> 
> Signed-off-by: John Keeping <john@metanate.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
