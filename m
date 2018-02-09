From: robh@kernel.org (Rob Herring)
Date: Thu, 8 Feb 2018 20:34:33 -0600
Subject: [PATCH 1/9] dt-bindings: add binding for Rockchip hdmi phy using
 an Innosilicon IP
In-Reply-To: <20180205143435.4723-2-heiko@sntech.de>
References: <20180205143435.4723-1-heiko@sntech.de>
 <20180205143435.4723-2-heiko@sntech.de>
Message-ID: <20180209023433.fgumy7ic6ol45x45@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 05, 2018 at 03:34:27PM +0100, Heiko Stuebner wrote:
> From: Zheng Yang <zhengyang@rock-chips.com>
> 
> The phy is used so far in two Rockchip socs the rk3228 and the rk3328.
> 
> Signed-off-by: Zheng Yang <zhengyang@rock-chips.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../bindings/phy/phy-rockchip-inno-hdmi.txt        | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-inno-hdmi.txt

Reviewed-by: Rob Herring <robh@kernel.org>
