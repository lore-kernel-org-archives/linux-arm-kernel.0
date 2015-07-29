From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 29 Jul 2015 16:22:57 +0530
Subject: [PATCH V3 02/16] PM / OPP: Create a directory for opp bindings
In-Reply-To: <cover.1438166099.git.viresh.kumar@linaro.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
Message-ID: <4dfe565ff17766b7df127d475d84958e96fdab1b.1438166099.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

More platform specific extended opp bindings will follow and it would be
easy to manage them with a directory for opp. Lets create that and move
the existing opp bindings into it.

Cc: Rob Herring <rob.herring@linaro.org>
Cc: devicetree at vger.kernel.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/power/{ => opp}/opp.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/power/{ => opp}/opp.txt (100%)

diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp/opp.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power/opp.txt
rename to Documentation/devicetree/bindings/power/opp/opp.txt
-- 
2.4.0
