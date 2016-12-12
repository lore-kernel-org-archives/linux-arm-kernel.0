From: robh@kernel.org (Rob Herring)
Date: Mon, 12 Dec 2016 09:39:11 -0600
Subject: [PATCH v3 6/6] mfd: dt: Move syscon bindings to syscon
 subdirectory
In-Reply-To: <20161206025321.1792-7-andrew@aj.id.au>
References: <20161206025321.1792-1-andrew@aj.id.au>
 <20161206025321.1792-7-andrew@aj.id.au>
Message-ID: <20161212153911.drhczoagyyhu7jm4@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2016 at 01:53:21PM +1100, Andrew Jeffery wrote:
> The use of syscons is growing, lets collate them in their own part of
> the bindings tree.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  Documentation/devicetree/bindings/mfd/{ => syscon}/aspeed-scu.txt         | 0
>  Documentation/devicetree/bindings/mfd/{ => syscon}/atmel-gpbr.txt         | 0
>  Documentation/devicetree/bindings/mfd/{ => syscon}/atmel-matrix.txt       | 0
>  Documentation/devicetree/bindings/mfd/{ => syscon}/atmel-smc.txt          | 0
>  Documentation/devicetree/bindings/mfd/{ => syscon}/qcom,tcsr.txt          | 0
>  Documentation/devicetree/bindings/mfd/{ => syscon}/syscon.txt             | 0
>  .../devicetree/bindings/mfd/{ => syscon}/ti-keystone-devctrl.txt          | 0
>  7 files changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/mfd/{ => syscon}/aspeed-scu.txt (100%)
>  rename Documentation/devicetree/bindings/mfd/{ => syscon}/atmel-gpbr.txt (100%)
>  rename Documentation/devicetree/bindings/mfd/{ => syscon}/atmel-matrix.txt (100%)
>  rename Documentation/devicetree/bindings/mfd/{ => syscon}/atmel-smc.txt (100%)
>  rename Documentation/devicetree/bindings/mfd/{ => syscon}/qcom,tcsr.txt (100%)
>  rename Documentation/devicetree/bindings/mfd/{ => syscon}/syscon.txt (100%)
>  rename Documentation/devicetree/bindings/mfd/{ => syscon}/ti-keystone-devctrl.txt (100%)

I'm not so sure this is the right direction. syscon usage is pretty much 
spread throughout the tree.

Rob
