From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 01 Apr 2016 18:34:46 +0200
Subject: [PATCH] ARM: dts: rockchip: update rk3288-veyron cpu operating
 points
In-Reply-To: <1459459483-5356-1-git-send-email-heiko@sntech.de>
References: <1459459483-5356-1-git-send-email-heiko@sntech.de>
Message-ID: <2836722.CXoAAzut2Z@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 31. M?rz 2016, 23:24:43 schrieb Heiko Stuebner:
> The generic operating points specified in rk3288.dtsi are specified by
> Rockchip as conservative and for all cases.
> 
> In contrast the Veyron ChromeOS devices are supposed to use a special
> chip variant often called rk3288-c and use different operating points
> in their kernel also including a higher max frequency.
> 
> So override the operating points for veyron devices.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

applied to my dts32 branch for 4.7
