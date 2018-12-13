Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEC6C6786C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:18:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C883420851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZD5KKs2l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C883420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=geW2j5i+GY5XMDZ1GosGjBa9lVRcBY24BGx+tPxBfQA=; b=ZD5KKs2lJh36Vn
	U4tdfhCO2n8v2slWnAJAFVBqICc0DWFB5CQe7LTh+vIs6phQ6w02qOi3F7pA332lFVdbzh3J8amTV
	scyB1lJ32Z4fot6rP77nygsE3B+P+pZecqxfBmqfUQNidQ7H3wSAlkcPftZCwuNi9lVoEfOkCjlGT
	NWt+/wTeeK4qGbW9GsKmGjYxwDz9/U0C0KwJJSTnISA2esesjD+jPmj607iAzIB3c+yU782RfTdev
	st7Todbmq2/zx0xPQImbnUeaYvabzvfDkYVYfSPxmjEdCuCHOu8abScVhTmkBvs1+WyCB7Fy+hmk4
	+SoWdSX5axg9z4v2aHHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXGa4-0006lG-HF; Thu, 13 Dec 2018 02:18:28 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXGZs-0006bm-Po
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 02:18:18 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id 004F6818E;
 Thu, 13 Dec 2018 02:18:11 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: Cosmetic fix for omap5 USB node names
Date: Wed, 12 Dec 2018 18:18:01 -0800
Message-Id: <20181213021801.49938-2-tony@atomide.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181213021801.49938-1-tony@atomide.com>
References: <20181213021801.49938-1-tony@atomide.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_181816_897420_AEB5CD6E 
X-CRM114-Status: UNSURE (   8.32  )
X-CRM114-Notice: Please train this message.
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, devicetree@vger.kernel.org,
 =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

These should be now using offset from the module base and not the
full physical address.

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap5-l4.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-l4.dtsi b/arch/arm/boot/dts/omap5-l4.dtsi
--- a/arch/arm/boot/dts/omap5-l4.dtsi
+++ b/arch/arm/boot/dts/omap5-l4.dtsi
@@ -195,7 +195,7 @@
 				#size-cells = <1>;
 				utmi-mode = <2>;
 				ranges = <0 0 0x20000>;
-				dwc3: dwc3@4a030000 {
+				dwc3: dwc3@10000 {
 					compatible = "snps,dwc3";
 					reg = <0x10000 0x10000>;
 					interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
@@ -332,14 +332,14 @@
 					      "refclk_60m_ext_p1",
 					      "refclk_60m_ext_p2";
 
-				usbhsohci: ohci@4a064800 {
+				usbhsohci: ohci@800 {
 					compatible = "ti,ohci-omap3";
 					reg = <0x800 0x400>;
 					interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
 					remote-wakeup-connected;
 				};
 
-				usbhsehci: ehci@4a064c00 {
+				usbhsehci: ehci@c00 {
 					compatible = "ti,ehci-omap";
 					reg = <0xc00 0x400>;
 					interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.19.2

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
