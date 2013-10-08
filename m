From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 08 Oct 2013 12:39:01 +0900
Subject: [PATCH 01/08] ARM: shmobile: r8a7791 PFC device tree node
In-Reply-To: <20131008033851.20455.68845.sendpatchset@w520>
References: <20131008033851.20455.68845.sendpatchset@w520>
Message-ID: <20131008033901.20455.32324.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add a DT node for the r8a7791 PFC device.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/r8a7791.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

--- 0001/arch/arm/boot/dts/r8a7791.dtsi
+++ work/arch/arm/boot/dts/r8a7791.dtsi	2013-10-04 18:31:44.000000000 +0900
@@ -71,4 +71,10 @@
 			      <0 16 4>,
 			      <0 17 4>;
 	};
+
+	pfc: pfc at e6060000 {
+		compatible = "renesas,pfc-r8a7791";
+		reg = <0 0xe6060000 0 0x250>;
+		#gpio-range-cells = <3>;
+	};
 };
