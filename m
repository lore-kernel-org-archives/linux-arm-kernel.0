From: pavel@denx.de (Pavel Machek)
Date: Tue, 8 Jul 2014 13:26:13 +0200
Subject: [PATCH 1/2] ARM: socfpga: Update socfpga_defconfig
In-Reply-To: <1403483462-21082-2-git-send-email-vbridgers2013@gmail.com>
References: <1403483462-21082-1-git-send-email-vbridgers2013@gmail.com>
 <1403483462-21082-2-git-send-email-vbridgers2013@gmail.com>
Message-ID: <20140708112613.GB8100@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun 2014-06-22 19:31:01, Vince Bridgers wrote:
> CONFIG_PM=y
> CONFIG_SUSPEND=y
> CONFIG_MMC_UNSAFE_RESUME=y
> CONFIG_DWMAC_SOCFPGA=y
> CONFIG_USB=y
> CONFIG_USB_DWC2=y
> CONFIG_USB_DWC2_HOST=y
> CONFIG_USB_DWC2_PLATFORM=y
> CONFIG_FHANDLE=y
> CONFIG_I2C=y
> CONFIG_I2C_DESIGNWARE_CORE=y
> CONFIG_I2C_DESIGNWARE_PLATFORM=y
> CONFIG_I2C_CHARDEV=y
> CONFIG_CAN=y
> CONFIG_CAN_RAW=y
> CONFIG_CAN_BCM=y
> CONFIG_CAN_GW=y
> CONFIG_CAN_DEV=y
> CONFIG_CAN_CALC_BITTIMING=y
> CONFIG_CAN_C_CAN=y
> CONFIG_CAN_C_CAN_PLATFORM=y
> CONFIG_WATCHDOG=y
> CONFIG_DW_WATCHDOG=y
> CONFIG_GPIOLIB=y
> CONFIG_GPIO_SYSFS=y
> CONFIG_GPIO_DWAPB=y
> CONFIG_PPS=y
> CONFIG_NETWORK_PHY_TIMESTAMPING=y
> CONFIG_PTP_1588_CLOCK=y
> CONFIG_VLAN_8021Q=y
> CONFIG_VLAN_8021Q_GVRP=y
> CONFIG_GARP=y
> CONFIG_IPV6=y
> CONFIG_HOTPLUG=y
> 
> Signed-off-by: Vince Bridgers <vbridgers2013@gmail.com>
> Signed-off-by: Alan Tull <atull@altera.com>
> Signed-off-by: Thor Thayer <tthayer@altera.com>

Acked-by: Pavel Machek <pavel@denx.de>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
