Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2A1C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:05:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B6F1217FB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vf12kF2R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B6F1217FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fQecGmzVfcg7FOTRkYtW4QU4+rzmbAQk5xdcxSpkiT4=; b=Vf12kF2RQnSMv2
	qiUIm3kSHN+s+ejK40MiIMzuu6OLzRiprGAJhn89GECwCe2vFbl1Irv9zRUWwXj2GSmqC3fO4cr5p
	rh9JxeP8QT9rgUo35w3gqGRyvVptIu+mer6jAiPiMODRn68nMqkU3MSvixa0LBL+fTFfQOhe9V1Z/
	m7njZG3vVZTT3/ZYG6ovpehLOiCYqeAVbB2aUVsuSvbXVkwwT5fPpCskI2ZfsJMs7Mn1rE7lJXdJ1
	J7H2QxG4HcVOrTLxJDbg6FBP7WtikDnKZvbrqEns2fBQEMwNUDSreLVA9nkfduaaJe7nCuMd0ECTT
	5N33RUIR8Q/s34pkZNVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYkAE-0000gQ-3C; Mon, 17 Dec 2018 04:05:54 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYk9g-0007mw-1J
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 04:05:26 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 535B95FCB4; Mon, 17 Dec 2018 12:05:03 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v3 03/15] dt-bindings: net: broadcom-bluetooth: Add BCM20702A1
 compatible string
Date: Mon, 17 Dec 2018 12:04:37 +0800
Message-Id: <20181217040449.31437-4-wens@csie.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181217040449.31437-1-wens@csie.org>
References: <20181217040449.31437-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_200520_893708_9D39D9AE 
X-CRM114-Status: GOOD (  10.69  )
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
Cc: Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
 Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 Loic Poulain <loic.poulain@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The BCM20702A1 is a Bluetooth 4.0 chip from Broadcom. It is found in the
Ampak AP6210 WiFi+BT module, identified from the read verbose config info
command response. However the Bluetooth firmware provided by vendors uses
the name BCM20710. This patch elects to use the chip ID returned by the
chip for the compatible string.

Reviewed-by: Rob Herring <robh@kernel.org>
Tested-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/net/broadcom-bluetooth.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
index 78cfa0fbece9..d9d734a07faf 100644
--- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
@@ -10,6 +10,7 @@ device the slave device is attached to.
 Required properties:
 
  - compatible: should contain one of the following:
+   * "brcm,bcm20702a1"
    * "brcm,bcm43438-bt"
 
 Optional properties:
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
