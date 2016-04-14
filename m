From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Thu, 14 Apr 2016 10:10:54 +0800
Subject: [PATCH v2 0/2]  rockchip: power-domain: support qos save and restore
Message-ID: <1460599856-4224-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add qos document in dt-bingings.
modify power domain driver to support qos save and restore.

Changes in v2:
[PATCH V2 2/2]: add some error handling.
		fix up the define and request space for qos_regmap and qos_save_regs. 

Elaine Zhang (2):
  dt-bindings: modify document of Rockchip power domains
  rockchip: power-domain: support qos save and restore

 .../bindings/soc/rockchip/power_domain.txt         |   8 ++
 drivers/soc/rockchip/pm_domains.c                  | 104 ++++++++++++++++++++-
 2 files changed, 109 insertions(+), 3 deletions(-)

-- 
1.9.1
