From: robh@kernel.org (Rob Herring)
Date: Wed, 20 Jun 2018 12:14:11 -0600
Subject: [PATCH v3 1/4] dt-bindings: add bindings for px30 clock controller
In-Reply-To: <1529029011-15021-2-git-send-email-zhangqing@rock-chips.com>
References: <1529029011-15021-1-git-send-email-zhangqing@rock-chips.com>
 <1529029011-15021-2-git-send-email-zhangqing@rock-chips.com>
Message-ID: <20180620181411.GA1689@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 15, 2018 at 10:16:48AM +0800, Elaine Zhang wrote:
> Add devicetree bindings for Rockchip cru which found on
> Rockchip SoCs.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  .../bindings/clock/rockchip,px30-cru.txt           | 66 ++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt

Reviewed-by: Rob Herring <robh@kernel.org>
