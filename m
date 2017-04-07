From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat,  8 Apr 2017 02:34:38 +0800
Subject: [PATCH v2 08/11] mfd: axp20x: add axp20x-regulator cell for AXP803
In-Reply-To: <20170407183441.58750-1-icenowy@aosc.io>
References: <20170407183441.58750-1-icenowy@aosc.io>
Message-ID: <20170407183441.58750-9-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As axp20x-regulator now supports AXP803, add a cell for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/mfd/axp20x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 2268a6a9aa2c..08b9bbd5bd71 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -839,6 +839,8 @@ static struct mfd_cell axp803_cells[] = {
 		.name			= "axp20x-pek",
 		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
 		.resources		= axp803_pek_resources,
+	}, {
+		.name			= "axp20x-regulator",
 	}
 };
 
-- 
2.12.2
