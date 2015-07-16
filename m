From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 16 Jul 2015 22:25:19 +0200
Subject: [PATCH] ARM: dts: rockchip: add rk3288 arm-pmu irq affinity
In-Reply-To: <3814250.tDdID2FGKL@diego>
References: <3814250.tDdID2FGKL@diego>
Message-ID: <9583081.xdEU9aRQPT@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 15. Juli 2015, 23:22:20 schrieb Heiko St?bner:
> The rk3288 uses spi irqs for the arm-pmu on individual cpu cores, so needs
> the affinity to them defined.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---

applied to my dts branch for 4.3 with Sonny's review.
