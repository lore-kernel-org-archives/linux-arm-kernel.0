From: niklas.soderlund@ragnatech.se (Niklas =?iso-8859-1?Q?S=F6derlund?=)
Date: Thu, 12 Jul 2018 10:13:28 +0200
Subject: [PATCH v5 3/6] dt-bindings: media: Document data-enable-active
 property
In-Reply-To: <1531145962-1540-4-git-send-email-jacopo+renesas@jmondi.org>
References: <1531145962-1540-1-git-send-email-jacopo+renesas@jmondi.org>
 <1531145962-1540-4-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <20180712081328.GT5237@bigcity.dyn.berto.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacopo,

On 2018-07-09 16:19:18 +0200, Jacopo Mondi wrote:
> Add 'data-enable-active' property to endpoint node properties list.
> 
> The property allows to specify the polarity of the data-enable signal, which
> when in active state determinates when data lines have to sampled for valid
> pixel data.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Acked-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  Documentation/devicetree/bindings/media/video-interfaces.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/video-interfaces.txt b/Documentation/devicetree/bindings/media/video-interfaces.txt
> index 52b7c7b..baf9d97 100644
> --- a/Documentation/devicetree/bindings/media/video-interfaces.txt
> +++ b/Documentation/devicetree/bindings/media/video-interfaces.txt
> @@ -113,6 +113,8 @@ Optional endpoint properties
>    Note, that if HSYNC and VSYNC polarities are not specified, embedded
>    synchronization may be required, where supported.
>  - data-active: similar to HSYNC and VSYNC, specifies data line polarity.
> +- data-enable-active: similar to HSYNC and VSYNC, specifies the data enable
> +  signal polarity.
>  - field-even-active: field signal level during the even field data transmission.
>  - pclk-sample: sample data on rising (1) or falling (0) edge of the pixel clock
>    signal.
> -- 
> 2.7.4
> 

-- 
Regards,
Niklas S?derlund
