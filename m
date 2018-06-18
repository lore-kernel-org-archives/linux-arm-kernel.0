From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 18 Jun 2018 08:05:12 -0300
Subject: [PATCH v2 1/2] ARM: dts: imx6qdl-sabreauto: Add sensors
In-Reply-To: <1be8dc197f842d3be31a15315594a25c8ad8f298.1529309235.git.leonard.crestez@nxp.com>
References: <1be8dc197f842d3be31a15315594a25c8ad8f298.1529309235.git.leonard.crestez@nxp.com>
Message-ID: <CAOMZO5AhN9K0wDZcsimM3f4O7KFp+7JkzjNmFJ9FDnJ131wX7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 5:15 AM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:
> The following sensors are on I2C3 on the baseboard:
> * isil,isl29023 light sensor
> * fsl,mag3110 magnetometer
> * fsl,mma8451 accelerometer
>
> Added under i2cmux/i2c at 1 because they're not otherwise accessible.
>
> These are all supported by iio with following configs:
> * CONFIG_SENSORS_ISL29018
> * CONFIG_MAG3110
> * CONFIG_MMA8452
>
> Tested with raw reads from iio sysfs.
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
