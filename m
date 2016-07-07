From: dawei.chien@mediatek.com (Dawei Chien)
Date: Thu, 7 Jul 2016 17:06:23 +0800
Subject: [PATCH 0/3] thermal: Add Mediatek thermal driver for mt2701
Message-ID: <1467882386-40544-1-git-send-email-dawei.chien@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series support for mt2701 chip to mtk_thermal.c,
and integrate both mt8173 and mt2701 on the same driver.
MT8173 has four banks and five sensors, and MT2701 has
only one bank and three sensors.
