From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 26 Mar 2014 16:39:15 +0000
Subject: [PATCH 01/15] mtd: st_spi_fsm: Add Macronix MX25L25655E device
In-Reply-To: <1395851969-13520-1-git-send-email-lee.jones@linaro.org>
References: <1395851969-13520-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1395851969-13520-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Angus Clark <angus.clark@st.com>

Add Macronix MX25L25655E to the list of known devices.

Signed-off-by: Angus Clark <angus.clark@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/devices/st_spi_fsm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index bea1416..2471061 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -380,6 +380,9 @@ static struct flash_info flash_types[] = {
 	{ "mx25l25635e", 0xc22019, 0, 64*1024, 512,
 	  (MX25_FLAG | FLASH_FLAG_32BIT_ADDR | FLASH_FLAG_RESET), 70,
 	  stfsm_mx25_config },
+	{ "mx25l25655e", 0xc22619, 0, 64*1024, 512,
+	  (MX25_FLAG | FLASH_FLAG_32BIT_ADDR | FLASH_FLAG_RESET), 70,
+	  stfsm_mx25_config},
 
 #define N25Q_FLAG (FLASH_FLAG_READ_WRITE       |	\
 		   FLASH_FLAG_READ_FAST         |	\
-- 
1.8.3.2
