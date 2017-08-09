From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Wed, 9 Aug 2017 18:12:37 +0800
Subject: [PATCH 0/2] add cpufreq support to MT7622
Message-ID: <cover.1502272372.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add cpufreq support to MT7622 SoC and also include some cleanups
with the generic naming to explicitly support all MediaTek SoCs.

Sean Wang (2):
  cpufreq: mediatek: add cleanups with the more generic naming
  cpufreq: mediatek: add support of cpufreq to MT7622 SoC

 drivers/cpufreq/mediatek-cpufreq.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

-- 
2.7.4
