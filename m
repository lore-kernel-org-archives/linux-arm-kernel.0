From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 30 Jan 2015 21:26:19 +0100
Subject: [PATCH 1/2] ARM: dts: rockchip: enable vops and hdmi output on
 rk3288-firefly and -evb
In-Reply-To: <3746086.qLJlieorB7@diego>
References: <3746086.qLJlieorB7@diego>
Message-ID: <5262226.LtqJymMnmT@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 30. Januar 2015, 00:42:30 schrieb Heiko St?bner:
> This enables the recently added display nodes on the firefly and evb,
> letting the boards output graphic data over the hdmi port.
> 
> This includes enabling of i2c5 on the evb that is used for ddc probing and
> setting the lcd-regulators to always on until the hdmi driver learns
> about using them.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---

added both to my dts branch
