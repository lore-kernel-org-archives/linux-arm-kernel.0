Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C63C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:22:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74D4B20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BZrv4h1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D4B20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Vj2kcELov60LEM8iMoUp3kD1Re0WbzZJkLgeDIO7Xxg=; b=BZrv4h1hiQN3Oa
	9NkySpn9bumMcnRWffLeyTGYZQQOHth4PAgbqt/QqL8khUi/48DJOXAOHb1jrv7pmjjPLE06mTPU+
	Z9QszilAHiQBwNG/OL1yDW6eclM9Dtas8CchKwJ2NjZCAVed6Iir6Vgm0p2w5gHND+UNw2rBStrzm
	mhyOhtl6FnIzClBhqyjccLkBNsg7EQrwr2BdIaTLyqQdMDQzzgE3KapC6Y2ogcKIvVq70bzO2RaHw
	P/8GnbPG2rNMZIFG4lpN9NjlW4cAheztQ4SFjQaV/q6qhCunpFWRSPG+m2/FdqNEX0/4UJrx/tCfu
	hJnLXTupovysCYcAfymA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goYxr-00034y-Ic; Tue, 29 Jan 2019 19:22:31 +0000
Received: from mleia.com ([178.79.152.223] helo=mail.mleia.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goYwU-0001p9-BP
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 19:21:08 +0000
Received: from mail.mleia.com (localhost [127.0.0.1])
 by mail.mleia.com (Postfix) with ESMTP id 2900B43EF23;
 Tue, 29 Jan 2019 19:21:00 +0000 (GMT)
From: Vladimir Zapolskiy <vz@mleia.com>
To: Sylvain Lemieux <slemieux.tyco@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Subject: [PATCH 07/13] ARM: dts: lpc32xx: phy3250: remove regulators umbrella
 device node
Date: Tue, 29 Jan 2019 21:20:43 +0200
Message-Id: <20190129192049.11223-8-vz@mleia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129192049.11223-1-vz@mleia.com>
References: <20190129192049.11223-1-vz@mleia.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190129_192100_189907_AE9AAE67 
X-CRM114-Status: GOOD (  11.64  )
/bin/ln: failed to access
 'reaver_cache/texts/20190129_192100_189907_AE9AAE67': No such file or
 directory
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_192100_189907_AE9AAE67 
X-CRM114-Status: GOOD (  10.33  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The originally added 'regulators' device node has a number of flaws,
to name a few its children has unit addresses but no reg properties,
the regulators are not captured by a device driver due to a missing
'simple-bus' compatible, the regulator names are selected by killing
either alphabetical order or device node grouping property.

The change removes 'regulators' device node and renames the regulators
and labels.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/lpc3250-phy3250.dts | 63 +++++++++++++--------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/arch/arm/boot/dts/lpc3250-phy3250.dts b/arch/arm/boot/dts/lpc3250-phy3250.dts
index ffcf78631b22..d2dad2b541ff 100644
--- a/arch/arm/boot/dts/lpc3250-phy3250.dts
+++ b/arch/arm/boot/dts/lpc3250-phy3250.dts
@@ -25,37 +25,6 @@
 		reg = <0x80000000 0x4000000>;
 	};
 
-	regulators {
-		backlight_reg: regulator@0 {
-			compatible = "regulator-fixed";
-			regulator-name = "backlight_reg";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			gpio = <&gpio 5 4 0>;
-			enable-active-high;
-			regulator-boot-on;
-		};
-
-		lcd_reg: regulator@1 {
-			compatible = "regulator-fixed";
-			regulator-name = "lcd_reg";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			gpio = <&gpio 5 0 0>;
-			enable-active-high;
-			regulator-boot-on;
-		};
-
-		sd_reg: regulator@2 {
-			compatible = "regulator-fixed";
-			regulator-name = "sd_reg";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio 5 5 0>;
-			enable-active-high;
-		};
-	};
-
 	leds {
 		compatible = "gpio-leds";
 
@@ -69,6 +38,36 @@
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	reg_backlight: regulator-backlight {
+		compatible = "regulator-fixed";
+		regulator-name = "backlight";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&gpio 5 4 0>;
+		enable-active-high;
+		regulator-boot-on;
+	};
+
+	reg_lcd: regulator-lcd {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&gpio 5 0 0>;
+		enable-active-high;
+		regulator-boot-on;
+	};
+
+	reg_sd: regulator-sd {
+		compatible = "regulator-fixed";
+		regulator-name = "sd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio 5 5 0>;
+		enable-active-high;
+		regulator-boot-on;
+	};
 };
 
 &clcd {
@@ -130,7 +129,7 @@
 	cd-gpios = <&gpio 3 1 0>;
 	cd-inverted;
 	bus-width = <4>;
-	vmmc-supply = <&sd_reg>;
+	vmmc-supply = <&reg_sd>;
 	status = "okay";
 };
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
