From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 24 Apr 2012 12:34:22 -0300
Subject: [PATCH 2/2] arm: imx: add missing select IMX_HAVE_PLATFORM for
 MACH_MX35_3DS in Kconfig
In-Reply-To: <1335280398-19769-3-git-send-email-mkl@pengutronix.de>
References: <1335280398-19769-1-git-send-email-mkl@pengutronix.de>
 <1335280398-19769-3-git-send-email-mkl@pengutronix.de>
Message-ID: <CAOMZO5AZs5+2wiAEEVEuMzeUtyhugZhW=OZZe+RuKM5V5i6zYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2012 at 12:13 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> @@ -571,8 +571,11 @@ config MACH_MX35_3DS
> ? ? ? ?select MXC_DEBUG_BOARD
> ? ? ? ?select IMX_HAVE_PLATFORM_FSL_USB2_UDC
> ? ? ? ?select IMX_HAVE_PLATFORM_IMX2_WDT
> + ? ? ? select IMX_HAVE_PLATFORM_IMX_FB
> ? ? ? ?select IMX_HAVE_PLATFORM_IMX_I2C
> ? ? ? ?select IMX_HAVE_PLATFORM_IMX_UART
> + ? ? ? select IMX_HAVE_PLATFORM_IPU_CORE
> + ? ? ? select IMX_HAVE_PLATFORM_MX2_CAMERA

mx35 should not select IMX_HAVE_PLATFORM_MX2_CAMERA as this only
applies for mx25/27.
