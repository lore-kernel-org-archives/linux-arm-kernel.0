From: robh@kernel.org (Rob Herring)
Date: Mon, 26 Mar 2018 17:23:01 -0500
Subject: [PATCH net-next 04/12] dt-bindings: net: dwmac-sun8i: Sort
 syscon compatibles by alphabetical order
In-Reply-To: <20180317092857.4396-5-wens@csie.org>
References: <20180317092857.4396-1-wens@csie.org>
 <20180317092857.4396-5-wens@csie.org>
Message-ID: <20180326222301.h4bnjovhulclgnok@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 17, 2018 at 05:28:49PM +0800, Chen-Yu Tsai wrote:
> The A83T syscon compatible was appended to the syscon compatibles list,
> instead of inserted in to preserve the ordering.
> 
> Move it to the proper place to keep the list sorted.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/net/dwmac-sun8i.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
