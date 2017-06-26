From: robh@kernel.org (Rob Herring)
Date: Mon, 26 Jun 2017 13:36:48 -0500
Subject: [PATCH 1/6] dt-bindings: mfd: axp20x: Add AXP806 to supported
 list of chips
In-Reply-To: <20170622040833.15329-2-wens@csie.org>
References: <20170622040833.15329-1-wens@csie.org>
 <20170622040833.15329-2-wens@csie.org>
Message-ID: <20170626183648.wyrt6ioayhsc6bh2@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 22, 2017 at 12:08:28PM +0800, Chen-Yu Tsai wrote:
> The binding already lists compatibles and regulators for the AXP806,
> but it is missing from the list of supported chips at the beginning.
> 
> Add it.
> 
> Fixes: 204ae2963e10 ("mfd: axp20x: Add bindings for AXP806 PMIC")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
