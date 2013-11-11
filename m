From: ivan.khoronzhuk@ti.com (Khoronzhuk, Ivan)
Date: Mon, 11 Nov 2013 16:55:09 +0000
Subject: [PATCH 04/12] mtd: nand: davinci: move bindings under mtd
In-Reply-To: <1384187188-5776-5-git-send-email-ivan.khoronzhuk@ti.com>
References: <1384187188-5776-1-git-send-email-ivan.khoronzhuk@ti.com>,
 <1384187188-5776-5-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <4F5844B3A985794BA902E12C070812375F8D08@DNCE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move bindings under mtd. Do this in order to make davinci-nand
driver usable by keystone architecture.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---
 .../{arm/davinci/nand.txt => mtd/davinci-nand.txt} |    0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{arm/davinci/nand.txt => mtd/davinci-nand.txt} (100%)

diff --git a/Documentation/devicetree/bindings/arm/davinci/nand.txt b/Documentation/devicetree/bindings/mtd/davinci-nand.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/davinci/nand.txt
rename to Documentation/devicetree/bindings/mtd/davinci-nand.txt
--
1.7.9.5
