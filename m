From: robh@kernel.org (Rob Herring)
Date: Fri, 13 Jan 2017 10:41:04 -0600
Subject: [PATCH v4 2/2] dt-bindings: clk: add rockchip,grf property for
 RK3399
In-Reply-To: <1484028930-20305-3-git-send-email-zhengxing@rock-chips.com>
References: <1484028930-20305-1-git-send-email-zhengxing@rock-chips.com>
 <1484028930-20305-3-git-send-email-zhengxing@rock-chips.com>
Message-ID: <20170113164104.2nneuzklorcrdekl@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2017 at 02:15:30PM +0800, Xing Zheng wrote:
> Add support for rockchip,grf property which is used for GRF muxes
> on RK3399.
> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> ---
> 
> Changes in v4:
> - update the decription for rockchip,grf property
> 
> Changes in v3: None
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.txt | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
