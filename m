From: trblinux@gmail.com (Tushar Behera)
Date: Thu, 19 Feb 2015 09:19:05 +0530
Subject: [alsa-devel] [PATCH 4/6] ASoC: samsung: Document binding for
 max98089 based Snow driver
In-Reply-To: <1424283959-16289-5-git-send-email-afaerber@suse.de>
References: <1424283959-16289-1-git-send-email-afaerber@suse.de>
 <1424283959-16289-5-git-send-email-afaerber@suse.de>
Message-ID: <54E55D31.7020807@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/18/2015 11:55 PM, Andreas F?rber wrote:
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  Documentation/devicetree/bindings/sound/snow.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/snow.txt b/Documentation/devicetree/bindings/sound/snow.txt
> index 6df74f15687f..1430a6bdb2ae 100644
> --- a/Documentation/devicetree/bindings/sound/snow.txt
> +++ b/Documentation/devicetree/bindings/sound/snow.txt
> @@ -2,6 +2,7 @@ Audio Binding for Snow boards
>  
>  Required properties:
>  - compatible : Can be one of the following,
> +			"google,snow-audio-max98089" or
>  			"google,snow-audio-max98090" or
>  			"google,snow-audio-max98091" or
>  			"google,snow-audio-max98095"
> 

Looks good.

Acked-by: Tushar Behera <trblinux@gmail.com>

-- 
Tushar Behera
