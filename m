From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 01 Sep 2016 13:43:42 +0200
Subject: [PATCH v3 4/5] arm64: dts: rockchip: add the gmac needed node for
 rk3399
In-Reply-To: <1472686132-27827-5-git-send-email-wxt@rock-chips.com>
References: <1472686132-27827-1-git-send-email-wxt@rock-chips.com>
 <1472686132-27827-5-git-send-email-wxt@rock-chips.com>
Message-ID: <4350667.JBNzRWMVzQ@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

Am Donnerstag, 1. September 2016, 07:28:51 schrieb Caesar Wang:
> The RK3399 GMAC Ethernet Controller provides a complete Ethernet interface
> from processor to a Reduced Media Independent Interface (RMII) and Reduced
> Gigabit Media Independent Interface (RGMII) compliant Ethernet PHY.
> 
> This patch adds the related needed device information.
> e.g.: interrupts, grf, clocks, pinctrl and so on.
> 
> The full details are in [0].
> 
> [0]:
> Documentation/devicetree/bindings/net/rockchip-dwmac.txt
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

the core rk3399 gmac support is still stuck and needs a respin. This patch is 
part of that other series as well which needs a respin itself.

Maybe you could just fold both series into one so that we don't have to track 
two.


Thanks
Heiko
