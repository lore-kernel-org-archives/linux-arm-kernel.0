From: arno@natisbad.org (Arnaud Ebalard)
Date: Sun, 16 Nov 2014 18:36:57 +0100
Subject: [PATCHv2 1/8] of: add "micron" vendor prefix for Micron
In-Reply-To: <cover.1416158990.git.arno@natisbad.org>
References: <cover.1416158990.git.arno@natisbad.org>
Message-ID: <1ec61e2819e349ee8e5e5892997315951024d6c4.1416158990.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Micron vendor prefix is not listed yet in vendor-prefixes.txt file. Even
if the expected vendor prefix should be the NASDAQ symbol ("mu" in that
case), it seems reasonable to use "micron" here because it is what is
already found at various locations inside the kernel (see files under
arch/arm/boot/dts/ for instance).

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 723999d73744..55a3a7f19063 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -96,6 +96,7 @@ mitsubishi	Mitsubishi Electric Corporation
 mosaixtech	Mosaix Technologies, Inc.
 moxa	Moxa
 mpl	MPL AG
+micron	Micron Technology, Inc.
 mundoreader	Mundo Reader S.L.
 murata	Murata Manufacturing Co., Ltd.
 mxicy	Macronix International Co., Ltd.
-- 
2.1.1
