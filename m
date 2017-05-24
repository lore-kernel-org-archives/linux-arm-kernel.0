From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 24 May 2017 15:54:12 +0200
Subject: [PATCH 4/7] arm64: defconfig: enable Rockchip spi driver
In-Reply-To: <20170524135415.5590-1-heiko@sntech.de>
References: <20170524135415.5590-1-heiko@sntech.de>
Message-ID: <20170524135415.5590-5-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It gets built in, as things like the cros-ec depend on the spi driver
being there on ChromeOS hardware - and ideally early on.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3aa4d54e1c0d..51c884f96125 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -265,6 +265,7 @@ CONFIG_SPI_MESON_SPIFC=m
 CONFIG_SPI_ORION=y
 CONFIG_SPI_PL022=y
 CONFIG_SPI_QUP=y
+CONFIG_SPI_ROCKCHIP=y
 CONFIG_SPI_S3C64XX=y
 CONFIG_SPI_SPIDEV=m
 CONFIG_SPMI=y
-- 
2.11.0
