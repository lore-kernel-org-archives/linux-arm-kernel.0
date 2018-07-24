From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 24 Jul 2018 15:26:00 +0200
Subject: [PATCH 2/3] arm64: dts: rockchip: add power button support for
 Firefly-RK3399
In-Reply-To: <PS2P216MB0532C24EED873485C60D8367D1530@PS2P216MB0532.KORP216.PROD.OUTLOOK.COM>
References: <20180718145727.30217-1-cheat.sc.linux@outlook.com>
 <PS2P216MB0532C24EED873485C60D8367D1530@PS2P216MB0532.KORP216.PROD.OUTLOOK.COM>
Message-ID: <2310530.dkOWXThdU1@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 18. Juli 2018, 16:58:21 CEST schrieb Maruyama Shohei:
> From: Shohei Maruyama <cheat.sc.linux@outlook.com>
> 
> This commit adds power button support for the Firefly-RK3399.
> 
> Signed-off-by: Shohei Maruyama <cheat.sc.linux@outlook.com>

applied for 4.19 with some minor changes, like reordering properties
and using a descriptive node name for the power buttons
and also using the correct wakeup property.

Thanks
Heiko
