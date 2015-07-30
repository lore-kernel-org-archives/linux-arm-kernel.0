From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 30 Jul 2015 22:27:19 +0530
Subject: [PATCH V3 resend] PM / OPP: Create a directory for opp bindings
In-Reply-To: <20150730165240.GF17794@linux>
References: <20150730165240.GF17794@linux>
Message-ID: <29597667e2c8afdbf396c5fcc9269fb27794131c.1438274711.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

More platform specific extended opp bindings will follow and it would be
easy to manage them with a directory for opp. Lets create that and move
the existing opp bindings into it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Resending to get cc list fixed, which isn't getting populated due to a
bug with get_maintainers.

 Documentation/devicetree/bindings/{power => opp}/opp.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{power => opp}/opp.txt (100%)

diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power/opp.txt
rename to Documentation/devicetree/bindings/opp/opp.txt
-- 
2.4.0
