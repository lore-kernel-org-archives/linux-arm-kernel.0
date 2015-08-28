From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 28 Aug 2015 09:53:20 +0200
Subject: [PATCH v1 2/3] pinctrl: rockchip: add support for the rk3036
In-Reply-To: <1440740808-15004-3-git-send-email-zhengxing@rock-chips.com>
References: <1440740808-15004-1-git-send-email-zhengxing@rock-chips.com>
 <1440740808-15004-3-git-send-email-zhengxing@rock-chips.com>
Message-ID: <2085107.a4DMzAYYyZ@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Freitag, 28. August 2015, 13:46:47 schrieb Xing Zheng:
> Many parts of pinctrl rk3036 are similar to rk2928's.
> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> ---
> 
> Changes in v1: None
> 
>  drivers/pinctrl/pinctrl-rockchip.c |   17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

please also add the new "rockchip,rk3036-pinctrl" compatible to 
Documentation/devicetree/pinctrl/rockchip,pinctrl.txt


I've checked the values against the rk3036 TRM and everything seems to fit, so 
with the missing compatible added to the binding you can add my

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


Heiko
