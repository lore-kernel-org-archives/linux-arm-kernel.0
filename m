From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 27 Jul 2015 10:32:31 +0530
Subject: [PATCH V2 01/11] opp: Create a directory for opp bindings
In-Reply-To: <cover.1437972635.git.viresh.kumar@linaro.org>
References: <cover.1437972635.git.viresh.kumar@linaro.org>
Message-ID: <f03c244df5f698e720bf961f64a61ac9daee717d.1437972635.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

More platform specific extended opp bindings will follow and it would be
easy to manage them with a directory for opp. Lets create that and move
the existing opp bindings into it.

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
