From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 27 Jul 2012 13:38:51 +0100
Subject: [PATCH 4/7] mfd: ab8500-core: Apply the AB8500 CODEC's compatible
 string to its MFD cell
In-Reply-To: <1343392734-11805-1-git-send-email-lee.jones@linaro.org>
References: <1343392734-11805-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1343392734-11805-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide a compatible string for the AB8500 CODEC to aid in
configuration property look-up from its associated Device Tree
node.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/ab8500-core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 626b4ec..0c5b70f 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -1076,6 +1076,7 @@ static struct mfd_cell __devinitdata ab8500_devs[] = {
 	},
 	{
 		.name = "ab8500-codec",
+		.of_compatible = "stericsson,ab8500-codec",
 	},
 };
 
-- 
1.7.9.5
