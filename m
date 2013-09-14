From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 14 Sep 2013 18:53:17 +0100
Subject: [PATCH 38/38] iio: magn-core: st: Provide support for the
 LSM303DLH
In-Reply-To: <1378817379-8238-39-git-send-email-lee.jones@linaro.org>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
 <1378817379-8238-39-git-send-email-lee.jones@linaro.org>
Message-ID: <5234A28D.1030409@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/13 13:49, Lee Jones wrote:
> Trivial patch adding the LSM303DLH to the list of already supported
> Magnetometer Sensors.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
err.
> index 12e7e79..b2e2917 100644
> --- a/drivers/iio/magnetometer/st_magn_core.c
> +++ b/drivers/iio/magnetometer/st_magn_core.c
> @@ -151,7 +151,8 @@ static const struct st_sensors st_magn_sensors[] = {
>  		.wai = ST_MAGN_1_WAI_EXP,
>  		.sensors_supported = {
>  			[0] = LSM303DLHC_MAGN_DEV_NAME,
> -			[1] = LSM303DLM_MAGN_DEV_NAME,
> +			[1] = LSM303DLH_MAGN_DEV_NAME,
> +			[0] = LSM303DLM_MAGN_DEV_NAME,
[2]?
>  		},
>  		.ch = (struct iio_chan_spec *)st_magn_16bit_channels,
>  		.odr = {
> 
