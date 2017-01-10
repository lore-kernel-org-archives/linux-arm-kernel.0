From: andy.gross@linaro.org (Andy Gross)
Date: Tue, 10 Jan 2017 08:53:48 -0600
Subject: [PATCH] ARM: defconfig: qcom: add APQ8060 DragonBoard devices
In-Reply-To: <20170110095521.14146-1-linus.walleij@linaro.org>
References: <20170110095521.14146-1-linus.walleij@linaro.org>
Message-ID: <20170110145348.GD5710@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2017 at 10:55:21AM +0100, Linus Walleij wrote:
> This default-enables the devices found on the APQ8060 DragonBoard
> in the qcom_defconfig:
> 
> - EBI2 bus
> - SMSC911x ethernet
> - LEDs class and PM8058 LEDs driver, trigger and heartbeat
>   trigger (so we get heartbeat on the board by default)
> - IIO framework, including the HRTimer trigger, KXSD9
>   accelerometer, MPU3050 gyroscope, AK8975 magnetometer and
>   BMP085 pressure sensor
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

This brings up a point of discussion.  Do we even need the qcom_defconfig any
more?  Is everyone comfortable with using the multi_v7_defconfig?

Aside from size of the image, i can't think of any other reason to keep around
the separate qcom file.


Regards,
Andy
