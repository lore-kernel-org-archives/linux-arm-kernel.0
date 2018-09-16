From: beagleboard@davidjohnsummers.uk (David Summers)
Date: Sun, 16 Sep 2018 19:16:36 +0100
Subject: [PATCH 3/3] Device Tree for ASUS Tinker Board S (v2)
In-Reply-To: <20180916181636.7938-1-beagleboard@davidjohnsummers.uk>
References: <20180916181636.7938-1-beagleboard@davidjohnsummers.uk>
Message-ID: <20180916181636.7938-4-beagleboard@davidjohnsummers.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 &emmc {
@@ -25,3 +114,7 @@
 	mmc-ddr-1_8v;
 	status = "okay";
 };
+
+&uart0 {
+	pinctrl-0 = <&uart0_xfer>, <&uart0_cts>;
+};
