From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 07 Sep 2016 20:21:18 +0200
Subject: [v14 PATCH 3/5] arm64: dts: rockchip: add Type-C phy for RK3399
In-Reply-To: <1472015825-11365-4-git-send-email-zyw@rock-chips.com>
References: <1472015825-11365-1-git-send-email-zyw@rock-chips.com>
 <1472015825-11365-4-git-send-email-zyw@rock-chips.com>
Message-ID: <2075415.Y46E4H7SDM@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 23. August 2016, 22:17:03 CEST schrieb Chris Zhong:
> There are 2 Type-C phy on RK3399, they are almost same, except the
> address of register. They support USB3.0 Type-C and DisplayPort1.3
> Alt Mode on USB Type-C. Register a phy, supply it to USB3 controller
> and DP controller.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

applied to my dts64 branch, after moving the rockchip,grf property down


Heiko
