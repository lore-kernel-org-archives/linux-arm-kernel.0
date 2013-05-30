From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 30 May 2013 16:51:52 +0200
Subject: [PATCH v7 10/11] ASoC: fsl: Move fsl-ssi binding doc to sound/
In-Reply-To: <1369925513-19329-1-git-send-email-mpa@pengutronix.de>
References: <1369925513-19329-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1369925513-19329-11-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fsl-ssi was located in powerpc/fsl/ssi.txt. This is no powerpc specific
device, so it should be moved to sound/ as it connects to differen audio
codecs.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 .../devicetree/bindings/{powerpc/fsl/ssi.txt => sound/fsl,ssi.txt}        | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{powerpc/fsl/ssi.txt => sound/fsl,ssi.txt} (100%)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/ssi.txt b/Documentation/devicetree/bindings/sound/fsl,ssi.txt
similarity index 100%
rename from Documentation/devicetree/bindings/powerpc/fsl/ssi.txt
rename to Documentation/devicetree/bindings/sound/fsl,ssi.txt
-- 
1.8.2.1
