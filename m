Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE6AC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:20:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 003FF2082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i6UX+uFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003FF2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+2JnqEUneS2fDLxQO1vu9txO7Zg2WnvR8fMoxayQ7y8=; b=i6UX+uFPc86K2z
	bP/e3frlsICKisB0M3E+t+hJWmgr3SoyeDKPANnxGpLEYdNSDXnKHBvjACT5CZSitd+tX0RCIQ9ll
	mhnNAcAqkte0/PrBmu2QIKvBG6NKIxqz3cgclmSa4l7cacyCexU9C4QH4xSMz2u5y9C4z09Y4TUZJ
	Lis0kw5kAC92paaNjuCJXVPs0KJ2RCc6t0DFonUEDDN6wT1X1CiiT9VohWCgunnxvhdk9KlaWEX9K
	g3qjDs3e8sm4dxOg6UVfmGzgm6r49iZhlg99Oj3fUXIV8QntcI+OgTmfSHnOooK1k6M5pe3J9DeMh
	031qqNQT5TREq9fL13TA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUtZv-00026X-55; Thu, 06 Dec 2018 13:20:31 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUtZq-0001kn-UI; Thu, 06 Dec 2018 13:20:28 +0000
Received: from we0660.dip.tu-dresden.de ([141.76.178.148] helo=phil.localnet)
 by gloria.sntech.de with esmtpsa
 (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256) (Exim 4.89)
 (envelope-from <heiko@sntech.de>)
 id 1gUtZd-0006Eg-8U; Thu, 06 Dec 2018 14:20:13 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 6/6] ARM: dts: rockchip: add BQ Edison 2 QC devicetree
Date: Thu, 06 Dec 2018 14:20:12 +0100
Message-ID: <2109428.orxuoO9QAy@phil>
In-Reply-To: <20181113130559.31221-7-heiko@sntech.de>
References: <20181113130559.31221-1-heiko@sntech.de>
 <20181113130559.31221-7-heiko@sntech.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_052027_122245_6ABD5CA3 
X-CRM114-Status: UNSURE (   8.98  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Dienstag, 13. November 2018, 14:05:59 CET schrieb Heiko Stuebner:
> From: Heiko Stuebner <heiko.stuebner@bq.com>
> 
> The Edison 2 Quad-Core was a Tablet device released in 2013 by MundoReader
> using a rk3188 soc. Add a devicetree for it.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>

applied for 4.21



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
