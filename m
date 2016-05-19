From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Thu, 19 May 2016 16:47:39 +0800
Subject: [PATCH v2] mmc: mmc: do not use CMD13 to get status after speed mode
Message-ID: <1463647662-27426-1-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

base on Adrian's comment to split it to 2 patches
fix switch timeout issue caused by jiffies
