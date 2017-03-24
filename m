From: robh@kernel.org (Rob Herring)
Date: Fri, 24 Mar 2017 13:27:37 -0500
Subject: [PATCH v4 2/4] dt-bindings: add the grf clock for dw-mipi-dsi
In-Reply-To: <1490147691-4489-3-git-send-email-zyw@rock-chips.com>
References: <1490147691-4489-1-git-send-email-zyw@rock-chips.com>
 <1490147691-4489-3-git-send-email-zyw@rock-chips.com>
Message-ID: <20170324182737.7txxjtynhczmefpr@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 09:54:49AM +0800, Chris Zhong wrote:
> For RK3399, the grf clock should be controlled by dw-mipi-dsi driver,
> add the description for this clock.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Reviewed-by: Sean Paul <seanpaul@chromium.org>
> ---
> 
> Changes in v4:
> - remove "additional"
> 
> Changes in v3: None
> Changes in v2: None
> 
>  .../devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
