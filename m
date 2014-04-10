From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu, 10 Apr 2014 10:21:02 +0200
Subject: [PATCH v2 3/4] Documentation: dt: reset: move socfpga-reset
In-Reply-To: <1397118063-21619-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1397118063-21619-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1397118063-21619-3-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of having the documentation for the socfpga-reset controller in a
vendor specific directory, move it to the reset folder to all the other
reset drivers.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 Documentation/devicetree/bindings/{arm/altera => reset}/socfpga-reset.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{arm/altera => reset}/socfpga-reset.txt (100%)

diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-reset.txt b/Documentation/devicetree/bindings/reset/socfpga-reset.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/altera/socfpga-reset.txt
rename to Documentation/devicetree/bindings/reset/socfpga-reset.txt
-- 
1.9.1
