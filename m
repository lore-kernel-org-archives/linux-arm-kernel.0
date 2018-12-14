Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88450C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 02:24:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 576F820811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 02:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="typpqajD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576F820811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FOWV9uHG9+mg9DG42UDaX/a1p/sjuXSd9jCzXgTzzBs=; b=typpqajD3ZzPd/
	EG2n9x6Akf3Wswgzi6Pjs6htB1QsiBlpi2yCBRYhdX4kZ2biPn346EGoHx2TrRaY7hKxMd7X3ARmT
	lsWCde6Cf8jCRcWw7UtYFhGnabplMjpOzSfsZ086hooiJPkZxwqJHvHpvQLmbTZb4BDjViKjIGyCf
	RzC1s3mz2c1ZtjfN4NzEJ/aVVdDqqbXZBAB1/4OBBbYObOifdYygQq6vO0NpWea4kcLseWinrmMcw
	HdersvWfPYfbDyinsQUjW6sFi0nDJL4RpkWTGBMmqIiMQNg+JUQyl/VktneoeKmfqA4hOfCs2SC77
	ox/tjPTJ9Pd02fByla7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXd9Z-0000Ac-FK; Fri, 14 Dec 2018 02:24:37 +0000
Received: from [1.203.163.78] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXd9W-0008Mg-0h; Fri, 14 Dec 2018 02:24:35 +0000
X-UUID: 980cd94c4d1a463892664daaa042d4b1-20181214
X-UUID: 980cd94c4d1a463892664daaa042d4b1-20181214
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
 (envelope-from <biao.huang@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 1531560930; Fri, 14 Dec 2018 10:24:07 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Fri, 14 Dec 2018 10:24:05 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Dec 2018 10:24:05 +0800
Message-ID: <1544754244.24219.135.camel@mhfsdcap03>
Subject: Re: [v7, PATCH 2/2] dt-binding: mediatek-dwmac: add binding
 document for MediaTek MT2712 DWMAC
From: biao huang <biao.huang@mediatek.com>
To: Andrew Lunn <andrew@lunn.ch>
Date: Fri, 14 Dec 2018 10:24:04 +0800
In-Reply-To: <20181213123658.GG1605@lunn.ch>
References: <1544666173-5121-1-git-send-email-biao.huang@mediatek.com>
 <1544666173-5121-3-git-send-email-biao.huang@mediatek.com>
 <20181213123658.GG1605@lunn.ch>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_182434_280486_04C98AFC 
X-CRM114-Status: UNSURE (   8.92  )
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
 netdev@vger.kernel.org, liguo.zhang@mediatek.com, joabreu@synopsys.com,
 linux-kernel@vger.kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
 linux-mediatek@lists.infradead.org, honghui.zhang@mediatek.com,
 yt.shen@mediatek.com, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Dear Andrew,

	Thanks for your comments.
On Thu, 2018-12-13 at 13:36 +0100, Andrew Lunn wrote:
> > +- mediatek,rx-delay-ps: RX clock delay macro value. Default is 0.
> > +	It should be defined for rgmii/rgmii-txid/mii/rmii interface.
> > +Both delay properties need to be a multiple of 170 for fine-tune rgmii,
> > +range 0~31*170.
> > +Both delay properties need to be a multiple of 550 for coarse-tune rgmii,
> > +range 0~31*550.
> > +Both delay properties need to be a multiple of 550 for mii/rmii,
> > +range 0~31*550.
> 
> You see "need to be" here, but the driver does not care. It will round
> down. Please either make the driver check, or change the text to
> rather say it will round down.
OK, will mark "round down" in the binding file.
> 
>        Andrew



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
