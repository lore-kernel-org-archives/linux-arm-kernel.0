From: robh@kernel.org (Rob Herring)
Date: Thu, 19 Jan 2017 09:42:32 -0600
Subject: [PATCH v2 01/11] dt-bindings: add rk3399 support for
 dw-mipi-rockchip
In-Reply-To: <1484561311-494-2-git-send-email-zyw@rock-chips.com>
References: <1484561311-494-1-git-send-email-zyw@rock-chips.com>
 <1484561311-494-2-git-send-email-zyw@rock-chips.com>
Message-ID: <20170119154231.pt2tytn67yip3g42@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2017 at 06:08:21PM +0800, Chris Zhong wrote:
> The dw-mipi-dsi of rk3399 is almost the same as rk3288, the rk3399 has
> additional phy config clock.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> ---
> 
>  .../devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt     | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
