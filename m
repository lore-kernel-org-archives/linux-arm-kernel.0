From: robh@kernel.org (Rob Herring)
Date: Wed, 31 May 2017 13:09:44 -0500
Subject: [PATCH 1/3] dt-bindings: clock: sunxi-ccu: Add compatible string
 for A83T PRCM
In-Reply-To: <20170526080025.28532-2-wens@csie.org>
References: <20170526080025.28532-1-wens@csie.org>
 <20170526080025.28532-2-wens@csie.org>
Message-ID: <20170531180944.dbg4adt33jcgbbjc@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 26, 2017 at 04:00:23PM +0800, Chen-Yu Tsai wrote:
> The A83T's PRCM has the same set of clocks and resets as the A64.
> However, a few dividers are different. And due to the lack of a low
> speed 32.768 kHz oscillator, a few of the clock parents are different.
> 
> The PRCM also has controls for various power domains. These are not
> supported yet.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/clock/sunxi-ccu.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
