From: jic23@kernel.org (Jonathan Cameron)
Date: Thu, 27 Apr 2017 06:19:35 +0100
Subject: [PATCH 3/3] iio: tools: generic_buffer: increase trigger length
In-Reply-To: <1492590045-17329-4-git-send-email-eugen.hristev@microchip.com>
References: <1492590045-17329-1-git-send-email-eugen.hristev@microchip.com>
 <1492590045-17329-4-git-send-email-eugen.hristev@microchip.com>
Message-ID: <b9f248a1-b65a-5e23-421c-4b8256cdddd6@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/04/17 09:20, Eugen Hristev wrote:
> Increased trigger length to 50 in order to cope with trigger names like
> fc030000.adc-dev0-external-rising
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
This is fine (though I'd go bigger as Daniel suggested)
I'll pick it up with the revised series.

thanks,

Jonathan
> ---
>  tools/iio/iio_utils.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/iio/iio_utils.h b/tools/iio/iio_utils.h
> index 780f201..9d59771 100644
> --- a/tools/iio/iio_utils.h
> +++ b/tools/iio/iio_utils.h
> @@ -13,7 +13,7 @@
>  #include <stdint.h>
>  
>  /* Made up value to limit allocation sizes */
> -#define IIO_MAX_NAME_LENGTH 30
> +#define IIO_MAX_NAME_LENGTH 50
>  
>  #define FORMAT_SCAN_ELEMENTS_DIR "%s/scan_elements"
>  #define FORMAT_TYPE_FILE "%s_type"
> 
