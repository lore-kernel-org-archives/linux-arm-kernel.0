From: Barry.Song@csr.com (Barry Song)
Date: Thu, 23 Aug 2012 10:47:52 +0800
Subject: [PATCH 1/3] ARM: PRIMA2: add missing interrupts property for pinctrl
 node
In-Reply-To: <1345690074-31327-1-git-send-email-Barry.Song@csr.com>
References: <1345690074-31327-1-git-send-email-Barry.Song@csr.com>
Message-ID: <1345690074-31327-2-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

commit 5130216265f6f924a4 missed the interrupts property

Signed-off-by: Barry Song <Barry.Song@csr.com>
---
 arch/arm/boot/dts/prima2-cb.dts |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/prima2-cb.dts b/arch/arm/boot/dts/prima2-cb.dts
index 34ae3a6..4245306 100644
--- a/arch/arm/boot/dts/prima2-cb.dts
+++ b/arch/arm/boot/dts/prima2-cb.dts
@@ -284,6 +284,7 @@
 				#interrupt-cells = <2>;
 				compatible = "sirf,prima2-gpio-pinmux";
 				reg = <0xb0120000 0x10000>;
+				interrupts = <43 44 45 46 47>;
 				gpio-controller;
 				interrupt-controller;
 			};
-- 
1.7.0.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
