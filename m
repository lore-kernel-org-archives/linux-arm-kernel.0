From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 08 Aug 2016 22:31:02 +0200
Subject: [PATCH] clk: rockchip: add clock flag parameter when register pll
In-Reply-To: <1469169465-5892-1-git-send-email-hl@rock-chips.com>
References: <1469169465-5892-1-git-send-email-hl@rock-chips.com>
Message-ID: <1629452.yetpgSEng2@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 22. Juli 2016, 14:37:45 schrieb Lin Huang:
> From: Heiko St?bner <heiko@sntech.de>
> 
> add clock flag parameter so we can pass specific clock flag
> (like CLK_GET_RATE_NOCACHE etc..)to pll driver.
> 
> Change-Id: I1e076b3efa6b5da082b6e68e2e2a4c9dfd93e3d4
> Signed-off-by: Heiko St?bner <heiko@sntech.de>
> Signed-off-by: Lin Huang <hl@rock-chips.com>

just so it doesn't get overlooked, this patch was also part of the later ddr-
clock series and I picked it from there,
