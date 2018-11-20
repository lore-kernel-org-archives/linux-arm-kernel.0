From: biao.huang@mediatek.com (Biao Huang)
Date: Tue, 20 Nov 2018 17:21:34 +0800
Subject: [v4, PATCH 0/2] add Ethernet driver support for mt2712
Message-ID: <1542705696-18507-1-git-send-email-biao.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v4:
modifications according to comments from Rob and Sean:
1. call clk_bulk api to simplify clk settings.
2. add prefix for mediatek specified properties
3. evolution to a more general driver
