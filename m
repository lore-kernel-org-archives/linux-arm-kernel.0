From: daniel.baluta@gmail.com (Daniel Baluta)
Date: Thu, 20 Apr 2017 19:06:30 +0300
Subject: [PATCH 3/3] iio: tools: generic_buffer: increase trigger length
In-Reply-To: <1492590045-17329-4-git-send-email-eugen.hristev@microchip.com>
References: <1492590045-17329-1-git-send-email-eugen.hristev@microchip.com>
 <1492590045-17329-4-git-send-email-eugen.hristev@microchip.com>
Message-ID: <CAEnQRZADGzSVJfTnd_L+aZ6uEiV5QntyF3mSWm8x0Wma4B3YJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 19, 2017 at 11:20 AM, Eugen Hristev
<eugen.hristev@microchip.com> wrote:
> Increased trigger length to 50 in order to cope with trigger names like
> fc030000.adc-dev0-external-rising
>
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
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

While at it, lets be brave and set it to 64. :)

Daniel.
