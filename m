From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 05 Sep 2018 10:07:24 +0300
Subject: [PATCH 3/6] dt-bindings: display: add data-enable polarity
 property
In-Reply-To: <20180905052113.21262-3-stefan@agner.ch>
References: <20180905052113.21262-1-stefan@agner.ch>
 <20180905052113.21262-3-stefan@agner.ch>
Message-ID: <139651706.L0sBFfZMDQ@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

Thank you for the patch.

On Wednesday, 5 September 2018 08:21:10 EEST Stefan Agner wrote:
> Allow to specify the data-enable polarity required by a dumb VGA
> DAC converting parallel RGB to VGA.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  .../devicetree/bindings/display/bridge/dumb-vga-dac.txt          | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
> b/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt index
> 164cbb15f04c..adbd2ca0af2f 100644
> --- a/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
> +++ b/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
> @@ -18,6 +18,7 @@ graph bindings specified in
> Documentation/devicetree/bindings/graph.txt.
> 
>  Optional properties:
>  - vdd-supply: Power supply for DAC
> +- de-active: data-enable pulse is active low/high/ignored

Which value corresponds to low, high and ignored ?

>  Example
>  -------

-- 
Regards,

Laurent Pinchart
