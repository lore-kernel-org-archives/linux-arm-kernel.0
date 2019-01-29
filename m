Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2036C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:23:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A161120882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h+7Po4DF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A161120882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ABoHzD8wH1ULLmMu720/iJmK8tuwqvWUTogBo1pzfMc=; b=h+7Po4DF0E2BCt
	zGJ9qN0hShukhZOITEltuDSqbRCXaHG2dE//B6PLEHaQWNcyjruXMSAMiZZWXIoW8DgDErHU2ct/v
	hvlXGGKec+n763GsBrZTN5JRCEWKkwY16drRq2bvG5FQGKGze1hXlyHNXmFYQ0sK/zXQR6tM3QsbQ
	UEEfFwu6ZoAQIzs9qJu0K9vp8pK2oOuyNgwux3tJm+cB+S83Qm1PY8wDzmLw2OJb8oOhMxCmWrsfi
	6edkKFxAdrUU7G24OvYjPCCTj5G8GfaHrl41h84oWvjBs6CQWk3h92NMng96x70k1FiXzM8z8Kdwh
	TpmK95Qina0uifID6Lcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goYyX-0003m7-6y; Tue, 29 Jan 2019 19:23:13 +0000
Received: from mleia.com ([178.79.152.223] helo=mail.mleia.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goYwV-0001pc-C0
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 19:21:09 +0000
Received: from mail.mleia.com (localhost [127.0.0.1])
 by mail.mleia.com (Postfix) with ESMTP id D21BA43EF2C;
 Tue, 29 Jan 2019 19:21:01 +0000 (GMT)
From: Vladimir Zapolskiy <vz@mleia.com>
To: Sylvain Lemieux <slemieux.tyco@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Subject: [PATCH 10/13] ARM: dts: lpc32xx: ea3250: add unit address to memory
 device node
Date: Tue, 29 Jan 2019 21:20:46 +0200
Message-Id: <20190129192049.11223-11-vz@mleia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129192049.11223-1-vz@mleia.com>
References: <20190129192049.11223-1-vz@mleia.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190129_192101_889334_9F6CC3BB 
X-CRM114-Status: GOOD (  10.96  )
/bin/ln: failed to access
 'reaver_cache/texts/20190129_192101_889334_9F6CC3BB': No such file or
 directory
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_192101_889334_9F6CC3BB 
X-CRM114-Status: GOOD (  10.12  )
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

The change adds a unit address to memory device node, the issue was
reported as a unit_address_vs_reg warning by dtc.

Root device node properties #address-cells and #size-cells were
removed as inherited from lpc32xx.dtsi.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/lpc3250-ea3250.dts | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/lpc3250-ea3250.dts b/arch/arm/boot/dts/lpc3250-ea3250.dts
index 58ea0a4e7afa..ef6b3e74cd9f 100644
--- a/arch/arm/boot/dts/lpc3250-ea3250.dts
+++ b/arch/arm/boot/dts/lpc3250-ea3250.dts
@@ -17,10 +17,8 @@
 / {
 	model = "Embedded Artists LPC3250 board based on NXP LPC3250";
 	compatible = "ea,ea3250", "nxp,lpc3250";
-	#address-cells = <1>;
-	#size-cells = <1>;
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x4000000>;
 	};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
