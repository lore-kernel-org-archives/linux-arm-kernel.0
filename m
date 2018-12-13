Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB47CC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:43:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B869320879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EwH8CXzE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B869320879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ihYwlUqy2v1q6PD4uth7WfmE1E306Ge13L83EmeYf2A=; b=EwH8CXzENMc4c8
	3AYvhWKxWj1l0JZFuJFtlTP9534s9B7H7FkqQmnE6df1MDLikFY48zFi5kjnMUB9gkqIZpTcO61GU
	pC7K7NFLvY5CL/8WxyUDIlh475kPwQc43RmGq4ifSkTqVqdcScQUKqTPLXdcuERkBzwA2A6fobu2B
	y27+E+UL1ZSdFuF06s5yOHkcbaaUTgiyqppCMl+zjG39Ilz9J5QWpD7G/S1ctm6d7JqEeNo0Tn3rf
	p/CFv7Ju8W6Z65z44bkEI3o6RwIQj+XGHG7+4z9iRr937NPHGPIlahvWrNOm0neLY1vzzIEVgWWZV
	kW9oeD2ycss8QObUtvFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXJmQ-0005of-K1; Thu, 13 Dec 2018 05:43:26 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXJmN-0005nk-Bo; Thu, 13 Dec 2018 05:43:24 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id A743C14B3D316;
 Wed, 12 Dec 2018 21:43:12 -0800 (PST)
Date: Wed, 12 Dec 2018 21:43:12 -0800 (PST)
Message-Id: <20181212.214312.763693432759368677.davem@davemloft.net>
To: biao.huang@mediatek.com
Subject: Re: [PATCH] net-next: stmmac: dwmac-mediatek: add module license info
From: David Miller <davem@davemloft.net>
In-Reply-To: <1544668897-6947-1-git-send-email-biao.huang@mediatek.com>
References: <1544668897-6947-1-git-send-email-biao.huang@mediatek.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Wed, 12 Dec 2018 21:43:13 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_214323_406894_45043B63 
X-CRM114-Status: UNSURE (   4.62  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, nelson.chang@mediatek.com,
 andrew@lunn.ch, netdev@vger.kernel.org, liguo.zhang@mediatek.com,
 joabreu@synopsys.com, linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 honghui.zhang@mediatek.com, yt.shen@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Biao Huang <biao.huang@mediatek.com>
Date: Thu, 13 Dec 2018 10:41:37 +0800

> Add MODULE_LICENSE info to fix this:
> WARNING: modpost: missing MODULE_LICENSE() in drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.o
> 
> Signed-off-by: Biao Huang <biao.huang@mediatek.com>

Applied, thanks for fixing this properly.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
