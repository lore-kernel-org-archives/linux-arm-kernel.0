From: robh@kernel.org (Rob Herring)
Date: Mon, 10 Jul 2017 22:03:12 -0500
Subject: [PATCH 1/2] dt-bindings: gpu: drop wrong compatible from midgard
 binding example
In-Reply-To: <20170710121227.14264-1-heiko@sntech.de>
References: <20170710121227.14264-1-heiko@sntech.de>
Message-ID: <20170711030312.ebkaditva2qim3yg@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 10, 2017 at 02:12:26PM +0200, Heiko Stuebner wrote:
> The binding rightfully only specifies compatibles for actual implementations
> and not for the whole family. In the example an arm,mali-midgard slipped
> through from downstream devicetrees though. So drop that to not confuse
> people reading (or copying) that example.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>

I'm assuming this will go thru same route arm,mali-midgard.txt got 
added.

Rob
