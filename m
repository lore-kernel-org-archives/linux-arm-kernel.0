From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 17 Nov 2016 16:55:09 +0100
Subject: [PATCH 1/2] arm64: defconfig: enable I2C and DW MMC controller on
 rockchip platform
In-Reply-To: <1473248790-27101-1-git-send-email-andy.yan@rock-chips.com>
References: <1473248790-27101-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1583509.9esYpYNt56@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 7. September 2016, 19:46:30 CET schrieb Andy Yan:
> I2C and MMC are very basic modules for a board to bootup, as I2C always
> used to configure PMIC and MMC devices often used to store filesytem.
> So enable them here to let the rockchip based arm64 boards can bootup.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

applied to a defconfig64 branch, after moving I2C_RK3X between QUP and TEGRA
RCAR seems to be an exception to the otherwise alphabetically sorted list.


Heiko
