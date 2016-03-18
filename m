From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Fri, 18 Mar 2016 15:17:22 +0800
Subject: [PATCH v1 0/2] rockchip: power-domain: support qos save and restore
Message-ID: <1458285444-31129-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add qos document in dt-bingings.
modify power domain driver to support qos save and restore.

Elaine Zhang (2):
  dt-bindings: modify document of Rockchip power domains
  rockchip: power-domain: support qos save and restore

 .../bindings/soc/rockchip/power_domain.txt         |  8 ++
 drivers/soc/rockchip/pm_domains.c                  | 87 +++++++++++++++++++++-
 2 files changed, 92 insertions(+), 3 deletions(-)

-- 
1.9.1
