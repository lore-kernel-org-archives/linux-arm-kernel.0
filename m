Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AA9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 06:06:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC52E214AE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 06:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S4TQcKBb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC52E214AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=QEn0UHMFHZSRlBqAY4ofT94i8qfwhfLj+LizYnVsH44=; b=S4T
	QcKBbOjVMkqXikSvm17KXyZIdVPOspNqgNA4LnYH3sVvBTzRennsS96CocIy65vi2skeLb/VxVFjN
	XvlafuiBUy2H5TBtG+TJ/DyEbf60ggpwoZEeoIWOFN0wIG1+evM9bfBHS7IVuscJsn4KBPa7UUPYP
	EkIKZ9O45r/8p1N1tzK4ngaN97P6AskyjI0nab+5Al9EoyrUEIAVqa8/ZvQsffZS6c0GWKHSnrdcp
	sb/W74MJWZ3iaFwQLePNFprqXTMv83N+YYhPedG6O2ZqWT5SUFrgJi+ijrHDTYrBk8M2klG2W5BmW
	p+KylK+u/ChM6O+wCPHpMvX66G57y9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcOnq-0002t3-TB; Thu, 27 Dec 2018 06:05:54 +0000
Received: from out1.zte.com.cn ([202.103.147.172] helo=mxct.zte.com.cn)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcOnl-0002s4-Br
 for linux-arm-kernel@lists.infradead.org; Thu, 27 Dec 2018 06:05:53 +0000
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
 by Forcepoint Email with ESMTPS id 8BA01C18A26A0155A9CE;
 Thu, 27 Dec 2018 14:05:37 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
 by mse01.zte.com.cn with ESMTP id wBR65R8r021644;
 Thu, 27 Dec 2018 14:05:27 +0800 (GMT-8)
 (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
 by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
 with ESMTP id 2018122714055608-19047492 ;
 Thu, 27 Dec 2018 14:05:56 +0800 
From: Peng Hao <peng.hao2@zte.com.cn>
To: linux@armlinux.org.uk
Subject: [PATCH]  arm/mm/pmsa-v8 : remove unneeded semicolon
Date: Thu, 27 Dec 2018 14:26:21 +0800
Message-Id: <1545891981-84215-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release
 8.5.3FP6|November 21, 2013) at 2018-12-27 14:05:56,
 Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-27 14:05:15, Serialize complete at 2018-12-27 14:05:15
X-MAIL: mse01.zte.com.cn wBR65R8r021644
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_220549_627884_C1F80952 
X-CRM114-Status: GOOD (  10.95  )
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
Cc: Peng Hao <peng.hao2@zte.com.cn>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Remove unneeded semicolon.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 arch/arm/mm/pmsa-v8.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/pmsa-v8.c b/arch/arm/mm/pmsa-v8.c
index 617a83d..0d7d5fb 100644
--- a/arch/arm/mm/pmsa-v8.c
+++ b/arch/arm/mm/pmsa-v8.c
@@ -165,7 +165,7 @@ static int __init pmsav8_setup_ram(unsigned int number, phys_addr_t start,phys_a
 		return -EINVAL;
 
 	bar = start;
-	lar = (end - 1) & ~(PMSAv8_MINALIGN - 1);;
+	lar = (end - 1) & ~(PMSAv8_MINALIGN - 1);
 
 	bar |= PMSAv8_AP_PL1RW_PL0RW | PMSAv8_RGN_SHARED;
 	lar |= PMSAv8_LAR_IDX(PMSAv8_RGN_NORMAL) | PMSAv8_LAR_EN;
@@ -181,7 +181,7 @@ static int __init pmsav8_setup_io(unsigned int number, phys_addr_t start,phys_ad
 		return -EINVAL;
 
 	bar = start;
-	lar = (end - 1) & ~(PMSAv8_MINALIGN - 1);;
+	lar = (end - 1) & ~(PMSAv8_MINALIGN - 1);
 
 	bar |= PMSAv8_AP_PL1RW_PL0RW | PMSAv8_RGN_SHARED | PMSAv8_BAR_XN;
 	lar |= PMSAv8_LAR_IDX(PMSAv8_RGN_DEVICE_nGnRnE) | PMSAv8_LAR_EN;
-- 
1.8.3.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
