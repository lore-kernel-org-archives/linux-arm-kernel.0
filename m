From: robh@kernel.org (Rob Herring)
Date: Mon, 12 Dec 2016 11:27:01 -0600
Subject: [PATCH 4/4] dt-bindings: input: Specify the interrupt number of
 TPS65217 power button
In-Reply-To: <20161209062833.5768-5-woogyom.kim@gmail.com>
References: <20161209062833.5768-1-woogyom.kim@gmail.com>
 <20161209062833.5768-5-woogyom.kim@gmail.com>
Message-ID: <20161212172701.7r26tns3i53ux4ds@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2016 at 03:28:33PM +0900, Milo Kim wrote:
> Specify the power button interrupt number which is from the datasheet.
> 
> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
> ---
>  Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
