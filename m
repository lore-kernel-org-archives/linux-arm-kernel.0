From: robh@kernel.org (Rob Herring)
Date: Wed, 25 May 2016 14:11:25 -0500
Subject: [PATCH 1/5] dt-bindings: document rk3399 rk-timer bindings
In-Reply-To: <1464169802-6033-2-git-send-email-wxt@rock-chips.com>
References: <1464169802-6033-1-git-send-email-wxt@rock-chips.com>
 <1464169802-6033-2-git-send-email-wxt@rock-chips.com>
Message-ID: <20160525191125.GA25213@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 25, 2016 at 05:49:58PM +0800, Caesar Wang wrote:
> From: Huang Tao <huangtao@rock-chips.com>
> 
> Add compatible string for rk3399 because which timer is a little
> different from older SoCs. So rename the file name from
> rockchip,rk3288-timer.txt to rockchip,rk-timer.txt.
> Clarify rockchip,rk3288-timer supported SoCs.
> 
> Signed-off-by: Huang Tao <huangtao@rock-chips.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> ---
> 
>  .../timer/{rockchip,rk3288-timer.txt => rockchip,rk-timer.txt}      | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>  rename Documentation/devicetree/bindings/timer/{rockchip,rk3288-timer.txt => rockchip,rk-timer.txt} (75%)

Acked-by: Rob Herring <robh@kernel.org>
