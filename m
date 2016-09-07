From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 07 Sep 2016 20:16:47 +0200
Subject: [PATCH v4 6/6] arm64: dts: rockchip: enable the gmac for rk3399
 evb board
In-Reply-To: <1472752204-8924-7-git-send-email-wxt@rock-chips.com>
References: <1472752204-8924-1-git-send-email-wxt@rock-chips.com>
 <1472752204-8924-7-git-send-email-wxt@rock-chips.com>
Message-ID: <1587027.EOPyfRoxyJ@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 2. September 2016, 01:50:04 CEST schrieb Caesar Wang:
> From: Roger Chen <roger.chen@rock-chips.com>
> 
> We add the required and optional properties for evb board.
> See the [0] to get the detail information.
> 
> [0]:
> Documentation/devicetree/bindings/net/rockchip-dwmac.txt
> 
> Signed-off-by: Roger Chen <roger.chen@rock-chips.com>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

applied to my dts64 branch,

after moving clkin_gmac and sorting the gmac properties according to their 
alphabetical position.


Heiko
