From: robh@kernel.org (Rob Herring)
Date: Mon, 29 Jan 2018 17:15:18 -0600
Subject: [PATCH] dt-bindings: display: stm32: correct clock-names in dsi
 panel example
In-Reply-To: <20180122153547.23470-1-philippe.cornu@st.com>
References: <20180122153547.23470-1-philippe.cornu@st.com>
Message-ID: <20180129231518.mocdpegeagbs4z5n@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 22, 2018 at 04:35:47PM +0100, Philippe Cornu wrote:
> In the dsi panel example, clock names in the "clock-names"
> field have been swapped:
> * "pclk" (peripheral clock) is <&rcc 1 CLK_F469_DSI> on stm32f4
> * "ref" (dsi phy pll ref clock) is <&clk_hse> on stm32f4
> 
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
>  Documentation/devicetree/bindings/display/st,stm32-ltdc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
