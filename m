From: robh@kernel.org (Rob Herring)
Date: Fri, 24 Jun 2016 14:19:31 -0500
Subject: [v3 PATCH 2/5] Documentation: bindings: add dt doc for Rockchip
 USB Type-C PHY
In-Reply-To: <1466686264-6744-3-git-send-email-zyw@rock-chips.com>
References: <1466686264-6744-1-git-send-email-zyw@rock-chips.com>
 <1466686264-6744-3-git-send-email-zyw@rock-chips.com>
Message-ID: <20160624191931.GA26329@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 23, 2016 at 08:51:01PM +0800, Chris Zhong wrote:
> This patch adds a binding that describes the Rockchip USB Type-C PHY
> for rk3399
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> 
> ---
> 
> Changes in v3:
> - use compatible: rockchip,rk3399-typec-phy
> - use dashes instead of underscores.
> 
> Changes in v2:
> - add some registers description
> 
> Changes in v1:
> - add extcon node description
> - move the registers in phy driver
> - remove the suffix of reset
> 
>  .../devicetree/bindings/phy/phy-rockchip-typec.txt | 74 ++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt

Acked-by: Rob Herring <robh@kernel.org>
