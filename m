From: robh@kernel.org (Rob Herring)
Date: Fri, 28 Apr 2017 15:37:27 -0500
Subject: [PATCH v2 29/30] dt-bindings: add vendor prefix for bananapi
In-Reply-To: <1493198774-4478-30-git-send-email-sean.wang@mediatek.com>
References: <1493198774-4478-1-git-send-email-sean.wang@mediatek.com>
 <1493198774-4478-30-git-send-email-sean.wang@mediatek.com>
Message-ID: <20170428203727.m6jm5w6nb2iirxih@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 26, 2017 at 05:26:13PM +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Banana Pi team in Sinovoip Co., Limited which are dedicated to
> design and manufacture open hardware product.
> 
> Website: http://www.banana-pi.org/
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index ec0bfb9..8ca0f3c 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -44,6 +44,7 @@ avia	avia semiconductor
>  avic	Shanghai AVIC Optoelectronics Co., Ltd.
>  axentia	Axentia Technologies AB
>  axis	Axis Communications AB
> +bananapi Banana Pi SINOVOP CO., LIMITED

s/SINOVOP/SINOVOIP/ 


>  boe	BOE Technology Group Co., Ltd.
>  bosch	Bosch Sensortec GmbH
>  boundary	Boundary Devices Inc.
> -- 
> 1.9.1
> 
