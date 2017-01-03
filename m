From: robh@kernel.org (Rob Herring)
Date: Tue, 3 Jan 2017 09:24:05 -0600
Subject: [PATCH v1 2/3] dt-bindings: add binding for rk3328 power domains
In-Reply-To: <1482464872-12954-3-git-send-email-zhangqing@rock-chips.com>
References: <1482464872-12954-1-git-send-email-zhangqing@rock-chips.com>
 <1482464872-12954-3-git-send-email-zhangqing@rock-chips.com>
Message-ID: <20170103152405.mdxrcf254kuqekom@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 23, 2016 at 11:47:51AM +0800, Elaine Zhang wrote:
> Add binding documentation for the power domains
> found on Rockchip RK3328 SoCs.
> But RK3328 SoC just support idle, not support pd.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/soc/rockchip/power_domain.txt | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
