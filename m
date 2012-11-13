From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 13 Nov 2012 06:32:02 -0800
Subject: [PATCH 2/2] hwmon: MMA8451: Add mma8451 3 axis digtial
 accelerometer driver
In-Reply-To: <1352796844-24216-1-git-send-email-Frank.Li@freescale.com>
References: <1352796844-24216-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20121113143202.GA18363@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2012 at 04:54:04PM +0800, Frank Li wrote:
> From: Sammy He <r62914@freescale.com>
> 
> Add mma8451 accelerometer driver.
> 
> Signed-off-by: Xinyu Chen <xinyu.chen@freescale.com>
> Signed-off-by: Sammy He <r62914@freescale.com>
> Signed-off-by: Frank Li <Frank.Li@freescale.com>
> ---
>  drivers/hwmon/Kconfig   |    7 +
>  drivers/hwmon/Makefile  |    1 +
>  drivers/hwmon/mma8451.c |  426 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 434 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/hwmon/mma8451.c
> 
Hi,

This is not a hardware monitoring driver. A better place would be
drivers/iio/accel/ or, if the driver is not ready for primetime,
drivers/staging/iio/accel/.

Thanks,
Guenter
