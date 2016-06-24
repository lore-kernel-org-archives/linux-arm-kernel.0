From: robh@kernel.org (Rob Herring)
Date: Fri, 24 Jun 2016 14:20:56 -0500
Subject: [v3 PATCH 4/5] Documentation: bindings: add dt documentation for
 cdn DP controller
In-Reply-To: <1466686264-6744-5-git-send-email-zyw@rock-chips.com>
References: <1466686264-6744-1-git-send-email-zyw@rock-chips.com>
 <1466686264-6744-5-git-send-email-zyw@rock-chips.com>
Message-ID: <20160624192056.GA27170@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 23, 2016 at 08:51:03PM +0800, Chris Zhong wrote:
> This patch adds a binding that describes the cdn DP controller for
> rk3399.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> 
> ---
> 
> Changes in v3:
> - add SoC specific compatible string
> - remove reg = <1>;
> 
> Changes in v2: None
> Changes in v1:
> - add extcon node description
> - add #sound-dai-cells description
> 
>  .../bindings/display/rockchip/cdn-dp-rockchip.txt  | 61 ++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/rockchip/cdn-dp-rockchip.txt

Acked-by: Rob Herring <robh@kernel.org>
