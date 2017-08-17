From: robh@kernel.org (Rob Herring)
Date: Thu, 17 Aug 2017 15:47:35 -0500
Subject: [PATCH v4 3/8] dt-bindings: pwm: add description for rv1108 pwm
In-Reply-To: <1502699868-8315-1-git-send-email-andy.yan@rock-chips.com>
References: <1502699477-8063-1-git-send-email-andy.yan@rock-chips.com>
 <1502699868-8315-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <20170817204735.vyifljtv5gxrcku6@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 04:37:48PM +0800, Andy Yan wrote:
> Add device tree bindings document for pwm on
> rockchip rv1108 soc.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> 
> ---
> 
> Changes in v4: None
> Changes in v3:
> - make the compatible string be: "rockchip,rv1108-pwm", "rockchip,rk3288-pwm"
>   for rv1108
> 
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/pwm/pwm-rockchip.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
