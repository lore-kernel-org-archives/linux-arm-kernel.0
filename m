From: robh@kernel.org (Rob Herring)
Date: Tue, 22 May 2018 10:58:09 -0500
Subject: [PATCH v6 2/5] Documentation: dt-bindings: phy: add phy_config
 for Rockchip USB Type-C PHY
In-Reply-To: <1526895424-22894-2-git-send-email-hl@rock-chips.com>
References: <1526895424-22894-1-git-send-email-hl@rock-chips.com>
 <1526895424-22894-2-git-send-email-hl@rock-chips.com>
Message-ID: <20180522155809.GA3988@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2018 at 05:37:01PM +0800, Lin Huang wrote:
> If want to do training outside DP Firmware, need phy voltage swing
> and pre_emphasis value.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
> Changes in v2:
> - None 
> Changes in v3:
> - modify property description and add this property to Example
> Changes in v4:
> - None
> Changes in v5:
> - None
> Changes in v6:
> - change rockchip,phy_config to rockchip,phy-config and descript it in detail.
>  
>  .../devicetree/bindings/phy/phy-rockchip-typec.txt | 36 +++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
