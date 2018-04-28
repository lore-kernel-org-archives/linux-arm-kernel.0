From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 28 Apr 2018 18:57:23 +0200
Subject: [PATCH 0/7] Defconfig updates for RK3399
In-Reply-To: <20180416144002.15569-1-ezequiel@collabora.com>
References: <20180416144002.15569-1-ezequiel@collabora.com>
Message-ID: <2336918.1QqQk43mrl@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 16. April 2018, 16:39:55 CEST schrieb Ezequiel Garcia:
> This series collects some pending defconfig patches
> from Enric, namely:
> 
> https://patchwork.kernel.org/patch/10302033/
> https://patchwork.kernel.org/patch/10247583/
> https://patchwork.kernel.org/patch/10269255/
> 
> And adds some more defconfig changes, required to
> support other peripherals:
> 
>  * Touchscreen, touchpad and stylus
>  * WiFi and Bluetooth
> 
> Series tested on RK3399 Kevin Chromebook.
> 
> Enric Balletbo i Serra (3):
>   arm64: defconfig: Enable typec-phy and extcon-usbc-cros-ec for rk3399
>   arm64: defconfig: Enable Rockchip io-domain driver
>   arm64: defconfig: Enable ChromeOS EC drivers for supported
>     Chromebooks.
> 
> Ezequiel Garcia (4):
>   arm64: defconfig: Enable HID over I2C drivers
>   arm64: defconfig: Enable Atmel Maxtouch driver
>   arm64: defconfig: Enable Marvell WiFi-Ex PCIe driver
>   arm64: defconfig: Enable bluetooth USB support

applied all 7 for 4.18


Thanks
Heiko
