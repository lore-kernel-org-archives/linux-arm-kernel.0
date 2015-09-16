From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 16 Sep 2015 10:28:31 +0200
Subject: [PATCH 6/6] pinctrl: samsung: Remove unneded semicolon
In-Reply-To: <1442392111-8448-1-git-send-email-javier@osg.samsung.com>
References: <1442392111-8448-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1442392111-8448-7-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's not needed an is just creating a null statement, so remove it.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/pinctrl/samsung/pinctrl-exynos5440.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos5440.c b/drivers/pinctrl/samsung/pinctrl-exynos5440.c
index 9ce0b8619d4c..82dc109f7ed4 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos5440.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos5440.c
@@ -284,7 +284,7 @@ static void exynos5440_dt_free_map(struct pinctrl_dev *pctldev,
 			if (!idx)
 				kfree(map[idx].data.configs.group_or_pin);
 		}
-	};
+	}
 
 	kfree(map);
 }
-- 
2.4.3
