From: robh@kernel.org (Rob Herring)
Date: Mon, 17 Sep 2018 01:44:40 -0400
Subject: [PATCH 03/27] dt-bindings: bus: add H6 DE3 bus binding
In-Reply-To: <20180902072643.4917-4-jernej.skrabec@siol.net>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
 <20180902072643.4917-4-jernej.skrabec@siol.net>
Message-ID: <5b9f3f49.1c69fb81.be303.28d7@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun,  2 Sep 2018 09:26:19 +0200, Jernej Skrabec wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> The Allwinner H6 DE3 bus is similar to the A64 DE2 one.
> 
> Add its compatible string with the A64 string as fallback to the
> binding.
> 
> Some description of the binding is modified to make it more generic.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
