From: horms@verge.net.au (Simon Horman)
Date: Fri, 7 Mar 2014 09:24:37 +0900
Subject: [PATCH v2 11/11] ARM: shmobile: koelsch/lager/multi defconfig:
 Enable MSIOF
In-Reply-To: <1393324219-3317-12-git-send-email-geert@linux-m68k.org>
References: <1393324219-3317-1-git-send-email-geert@linux-m68k.org>
 <1393324219-3317-12-git-send-email-geert@linux-m68k.org>
Message-ID: <20140307002437.GD11702@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 11:30:19AM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Hi Geert,

as discussed elsewhere I have queued up the multiplatform portion of this patch.
For reference the patch that I have queued up is as follows.


From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

ARM: shmobile: multiplatform: Enable MSIOF in defconfig

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 83b0725..2a27d46 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -78,6 +78,7 @@ CONFIG_I2C_GPIO=y
 CONFIG_I2C_RCAR=y
 CONFIG_SPI=y
 CONFIG_SPI_RSPI=y
+CONFIG_SPI_SH_MSIOF=y
 CONFIG_GPIO_EM=y
 CONFIG_GPIO_RCAR=y
 # CONFIG_HWMON is not set
-- 
1.8.5.2
