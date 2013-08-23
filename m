From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 23 Aug 2013 19:12:19 -0300
Subject: [PATCH v2 6/9] watchdog: orion: Rename device-tree binding
 documentation
In-Reply-To: <1377295942-5955-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377295942-5955-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1377295942-5955-7-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Name this file to something a bit more judicious.

Cc: devicetree at vger.kernel.org
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 Documentation/devicetree/bindings/watchdog/{marvel.txt => orion-wdt.txt} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/watchdog/{marvel.txt => orion-wdt.txt} (100%)

diff --git a/Documentation/devicetree/bindings/watchdog/marvel.txt b/Documentation/devicetree/bindings/watchdog/orion-wdt.txt
similarity index 100%
rename from Documentation/devicetree/bindings/watchdog/marvel.txt
rename to Documentation/devicetree/bindings/watchdog/orion-wdt.txt
-- 
1.8.1.5
