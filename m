From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu,  9 Oct 2014 14:39:06 +0200
Subject: [PATCH RFT 8/8] ARM: berlin: Enable ethernet on Sony NSZ-GS7
In-Reply-To: <1412858346-11334-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1412858346-11334-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1412858346-11334-9-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marvell Berlin BG2 based Sony NSZ-GS7 has one ethernet controller
connected to rear RJ45 jack. Enable it by default.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: "Antoine T?nart" <antoine.tenart@free-electrons.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: netdev at vger.kernel.org
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts b/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
index c72bfd468d10..27f2f0ad7562 100644
--- a/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
+++ b/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
@@ -26,4 +26,6 @@
 	};
 };
 
+&eth1 { status = "okay"; };
+
 &uart0 { status = "okay"; };
-- 
2.1.1
