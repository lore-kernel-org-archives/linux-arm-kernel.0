From: robh@kernel.org (Rob Herring)
Date: Thu, 8 Jun 2017 17:22:07 -0500
Subject: [PATCH 1/3] dt-bindings: pinctrl: sunxi: Add compatible string
 for A83T R_PIO
In-Reply-To: <20170603144427.22855-2-wens@csie.org>
References: <20170603144427.22855-1-wens@csie.org>
 <20170603144427.22855-2-wens@csie.org>
Message-ID: <20170608222207.gi2m5gjetmtxiyxj@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 03, 2017 at 10:44:25PM +0800, Chen-Yu Tsai wrote:
> The R_PIO on the A83T is almost the same as the one found on the A64,
> except that the CIR_RX function was moved from pin PL11 to pin PL12.
> 
> Add a compatible string for it.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
