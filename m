From: robh@kernel.org (Rob Herring)
Date: Mon, 26 Jun 2017 13:38:09 -0500
Subject: [PATCH 2/6] dt-bindings: mfd: axp20x: Introduce bindings for
 AXP813
In-Reply-To: <20170622040833.15329-3-wens@csie.org>
References: <20170622040833.15329-1-wens@csie.org>
 <20170622040833.15329-3-wens@csie.org>
Message-ID: <20170626183809.uzdk7boe7egbw6i6@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 22, 2017 at 12:08:29PM +0800, Chen-Yu Tsai wrote:
> The X-Powers AXP813 is a PMIC designed to be paired with Allwinner's
> A83T SoC. There is also an AXP818, which is paired with the H8 SoC.
> 
> The two models seem to be identical, apart from the external markings.
> 
> This patch introduces the basic mfd and regulator bindings for the
> AXP813.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 49 +++++++++++++++++++++---
>  1 file changed, 44 insertions(+), 5 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
