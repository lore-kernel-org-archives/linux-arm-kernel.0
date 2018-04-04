From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 04 Apr 2018 12:25:32 +0300
Subject: [PATCH v5 5/5] drm/docs: Remove the rcar alpha from the csv file
In-Reply-To: <e0d2cf7e9b111282b9b50f0531cd61a2ed22c407.1522829034.git-series.maxime.ripard@bootlin.com>
References: <cover.5437f7a0834f12076bc0a4eba52226f28b2e0dda.1522829034.git-series.maxime.ripard@bootlin.com>
 <e0d2cf7e9b111282b9b50f0531cd61a2ed22c407.1522829034.git-series.maxime.ripard@bootlin.com>
Message-ID: <9178266.Jiyqifsqpg@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Thank you for the patch.

On Wednesday, 4 April 2018 11:04:23 EEST Maxime Ripard wrote:
> Now that we moved the rcar-du DRM driver has been switched to the generic
> alpha property, remove the former property documentation from the
> deperecated CSV file.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  Documentation/gpu/kms-properties.csv | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/gpu/kms-properties.csv
> b/Documentation/gpu/kms-properties.csv index 6b28b014cb7d..07ed22ea3bd6
> 100644
> --- a/Documentation/gpu/kms-properties.csv
> +++ b/Documentation/gpu/kms-properties.csv
> @@ -98,5 +98,4 @@ radeon,DVI-I,?coherent?,RANGE,"Min=0, Max=1",Connector,TBD
> ,,"""underscan vborder""",RANGE,"Min=0, Max=128",Connector,TBD
>  ,Audio,?audio?,ENUM,"{ ""off"", ""on"", ""auto"" }",Connector,TBD
>  ,FMT Dithering,?dither?,ENUM,"{ ""off"", ""on"" }",Connector,TBD
> -rcar-du,Generic,"""alpha""",RANGE,"Min=0, Max=255",Plane,TBD
>  ,,"""colorkey""",RANGE,"Min=0, Max=0x01ffffff",Plane,TBD


-- 
Regards,

Laurent Pinchart
