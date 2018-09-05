From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 05 Sep 2018 21:17:04 +0200
Subject: [PATCH v2] ARM: dts: rockchip: add rk3188 lcd controller nodes
In-Reply-To: <20180831072537.15785-1-heiko@sntech.de>
References: <20180831072537.15785-1-heiko@sntech.de>
Message-ID: <3757715.Y541dOOzu4@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 31. August 2018, 09:25:37 CEST schrieb Heiko Stuebner:
> Add the core display subsystem and vop nodes to rk3188.
> Vop0 has a fully dedicated set of pins and only vop1 needs to
> do pinctrl to have display output, so also add the necessary
> pinctrl entries for it.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

applied for 4.20
