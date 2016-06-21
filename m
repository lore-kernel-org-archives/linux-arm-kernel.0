From: Yisen.Zhuang@huawei.com (Yisen Zhuang)
Date: Tue, 21 Jun 2016 11:56:24 +0800
Subject: [PATCH net-next 04/19] net: hns: typo fix of annotation info for
 hns_nic_reset_subtask()
In-Reply-To: <1466481399-70080-1-git-send-email-Yisen.Zhuang@huawei.com>
References: <1466481399-70080-1-git-send-email-Yisen.Zhuang@huawei.com>
Message-ID: <1466481399-70080-5-git-send-email-Yisen.Zhuang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qianqian Xie <xieqianqian@huawei.com>

The annotation info for hns_nic_reset_subtask() should be
"for resetting subtask" instead of "for resetting suntask".

Signed-off-by: Qianqian Xie <xieqianqian@huawei.com>
Signed-off-by: Yisen Zhuang <Yisen.Zhuang@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_enet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index 15200e4..b978db4 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -1633,7 +1633,7 @@ static void hns_nic_dump(struct hns_nic_priv *priv)
 	}
 }
 
-/* for resetting suntask*/
+/* for resetting subtask */
 static void hns_nic_reset_subtask(struct hns_nic_priv *priv)
 {
 	enum hnae_port_type type = priv->ae_handle->port_type;
-- 
1.9.1
