From: olof@lixom.net (Olof Johansson)
Date: Tue, 15 May 2018 13:53:54 -0700
Subject: [GIT PULL 4/4] Rockchip arm64 defconfig updates for 4.18 round 1
In-Reply-To: <2676342.8y6AX4oR9f@phil>
References: <2000491.bLgWuj0xar@phil>
 <2676342.8y6AX4oR9f@phil>
Message-ID: <20180515205354.whll4pj74exaci5h@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2018 at 12:40:05PM +0200, Heiko Stuebner wrote:
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.18-rockchip-defconfig64-1
> 
> for you to fetch changes up to 214f2c319a140f8a0121f362ad8e73ea1576d5ad:
> 
>   arm64: defconfig: enable rockchip efuse (2018-05-09 16:33:09 +0200)
> 
> ----------------------------------------------------------------
> Enablement of Rockchip-specific efuse, io-domain and typec drivers
> as well as general cros-ec, hid, touchscreen bluetooth and wifi-drivers
> on 64bit arm platforms.
> 
> ----------------------------------------------------------------
> Enric Balletbo i Serra (3):
>       arm64: defconfig: Enable typec-phy and extcon-usbc-cros-ec for rk3399
>       arm64: defconfig: Enable Rockchip io-domain driver
>       arm64: defconfig: Enable ChromeOS EC drivers for supported Chromebooks.
> 
> Ezequiel Garcia (4):
>       arm64: defconfig: Enable HID over I2C drivers
>       arm64: defconfig: Enable Atmel Maxtouch driver
>       arm64: defconfig: Enable Marvell WiFi-Ex PCIe driver
>       arm64: defconfig: Enable bluetooth USB support
> 
> Heiko Stuebner (1):
>       arm64: defconfig: enable rockchip efuse

Merged. Not sure if it's useful to split defconfig updates quite this granular,
might make sense to just do slightly more consolidated patches.

Anyway, no harm, just a bit verbose.


-Olof
