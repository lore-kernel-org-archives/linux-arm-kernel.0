Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47808C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:06:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C5B120645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iQAS+anO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C5B120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Askq2WCeqAfnmAKLOpV4uc365o3vCrl13Eg6YhdB5yI=; b=iQAS+anOQxuXmG
	Q7MrX2FbIQORQ3wTyu/rSTvWGhf8oDBFyE6DY/iYy6bDR6hwIk+HMwJMICmQu/bCrMV6Aks6sqDRN
	qbEiqV2yfqZlQ0RGHbz4QoXF3yW18PUa7iGPCAGVo4KVBwqh0N2nvTDYdK7bJZF0QUoqckZPfT2Mu
	l5883kS+di+DyPgZKfEnihIxgq8B2Y4JWhPkAlQsJE9z/qVNpz3c2q5jlbgjhmb4Z+UFdcOkJh019
	P/mWuBXvThsxY9VEuLGr7l2xlXrGM46oWQlqED8zvxN2SMCQBh+vHdjIbSNSVoX4Wzo98dI3S3X9J
	wz0VBklhq0fb//81ILOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvicg-0006iS-Ax; Mon, 18 Feb 2019 13:06:14 +0000
Received: from coyote.holtmann.net ([212.227.132.17] helo=mail.holtmann.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvicY-0006hf-Pr; Mon, 18 Feb 2019 13:06:13 +0000
Received: from marcel-macpro.fritz.box (p4FF9F361.dip0.t-ipconnect.de
 [79.249.243.97])
 by mail.holtmann.org (Postfix) with ESMTPSA id 0DA33CF2C7;
 Mon, 18 Feb 2019 14:13:59 +0100 (CET)
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 2/6] Bluetooth: mediatek: trivial typo fix
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <fe55645efb173ef11cad6e43c194b400226b7a2f.1550184473.git.sean.wang@mediatek.com>
Date: Mon, 18 Feb 2019 14:06:05 +0100
Message-Id: <E7DDB747-D3D7-4D31-BEA9-9277D95C2687@holtmann.org>
References: <cover.1550184473.git.sean.wang@mediatek.com>
 <fe55645efb173ef11cad6e43c194b400226b7a2f.1550184473.git.sean.wang@mediatek.com>
To: Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_050606_988452_DE558355 
X-CRM114-Status: UNSURE (   7.38  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, robh+dt@kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Sean,

> add a trivial typo fix from speicfic to specific
> 
> Fixes: 7237c4c9ec92 ("Bluetooth: mediatek: Add protocol support for MediaTek serial devices")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> drivers/bluetooth/btmtkuart.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
