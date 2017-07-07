From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 7 Jul 2017 11:56:46 +0800
Subject: [PATCH v3 2/3] dt-bindings: cpufreq: move MediaTek cpufreq
 dt-bindings document to proper place
In-Reply-To: <cover.1499399121.git.sean.wang@mediatek.com>
References: <cover.1499399121.git.sean.wang@mediatek.com>
Message-ID: <77ada8e9c184b4a58463bfe0f2c8b0ef149d2845.1499399121.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

The old place is Documentation/devicetree/bindings/clock/ that would
let people hard to find how to use MediaTek cpufreq driver, so moving
it to the appropriate place as other cpufreq drivers done would be
better.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../bindings/{clock/mt8173-cpu-dvfs.txt => cpufreq/cpufreq-mediatek.txt}  | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{clock/mt8173-cpu-dvfs.txt => cpufreq/cpufreq-mediatek.txt} (100%)

diff --git a/Documentation/devicetree/bindings/clock/mt8173-cpu-dvfs.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
similarity index 100%
rename from Documentation/devicetree/bindings/clock/mt8173-cpu-dvfs.txt
rename to Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
-- 
2.7.4
