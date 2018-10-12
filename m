From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 12 Oct 2018 13:25:24 +0900
Subject: [PATCH v2 2/2] dt-bindings: uniphier: move cache-uniphier.txt to
 vendor directory
In-Reply-To: <1539318324-4938-1-git-send-email-yamada.masahiro@socionext.com>
References: <1539318324-4938-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1539318324-4938-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now, the Socionext vendor directory is available at
Documentation/devicetree/bindings/arm/socionext/

Move cache-uniphier.txt over to it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - New patch

 .../devicetree/bindings/arm/{uniphier => socionext}/cache-uniphier.txt    | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/arm/{uniphier => socionext}/cache-uniphier.txt (100%)

diff --git a/Documentation/devicetree/bindings/arm/uniphier/cache-uniphier.txt b/Documentation/devicetree/bindings/arm/socionext/cache-uniphier.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/uniphier/cache-uniphier.txt
rename to Documentation/devicetree/bindings/arm/socionext/cache-uniphier.txt
-- 
2.7.4
