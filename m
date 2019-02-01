Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D110C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 02:05:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5983720863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 02:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ipeBitev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5983720863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H1eTBs7VHRMrEuc34VE7siepf6lNGiz2SZvu6n8Rkm0=; b=ipeBitevUsJHpE
	zQhs72hRvvgfwA3YTyXCLkvaNYx8x+efBMOGoxctc7HYCij7S10I2YqI2Q8QmILG63sv6vA4TijEC
	4OYJ9Ran6v05M8Q7exHrT52OhM+NSpL3ek6hfj+C9+PgqZbePmibgu+2ZWEnDvpy5sG2cw6/MxyeS
	yHZEJzTBdQ6DdzgGFLoLXmMqZzZE9XDzRw0+qyGPdwUJ+gXPLqyBFu71xPj+sTtKdCpJaTKXe8yiu
	HtJcZCohpwAvT1uwVDmkY2qWAsSG+VC7KWOSzFEVR4DkY2ZCY+ggb9DCA79cUANC709LaS3UUT0h2
	gwtaGPgUxT+LX/UmF+oA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpOCc-00047H-2y; Fri, 01 Feb 2019 02:05:10 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpOCX-0003PQ-RW; Fri, 01 Feb 2019 02:05:07 +0000
X-UUID: 73402dab3a9a4431b482075f40a736e4-20190131
X-UUID: 73402dab3a9a4431b482075f40a736e4-20190131
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
 (envelope-from <ck.hu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 627047803; Thu, 31 Jan 2019 18:04:57 -0800
Received: from mtkmbs03n2.mediatek.inc (172.21.101.182) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 31 Jan 2019 18:04:55 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 10:04:46 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Feb 2019 10:04:46 +0800
Message-ID: <1548986686.7501.5.camel@mtksdaap41>
Subject: Re: [PATCH 01/10] soc: mediatek: add mt8183 compatible name
From: CK Hu <ck.hu@mediatek.com>
To: Bibby Hsieh <bibby.hsieh@mediatek.com>
Date: Fri, 1 Feb 2019 10:04:46 +0800
In-Reply-To: <1548747128-60136-2-git-send-email-bibby.hsieh@mediatek.com>
References: <1548747128-60136-1-git-send-email-bibby.hsieh@mediatek.com>
 <1548747128-60136-2-git-send-email-bibby.hsieh@mediatek.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: EA629AC00DE73A5A1C7FAB28DEF6A8B71823536838DA3B120BF0BFC539CB1E882000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_180505_921000_D2DD8249 
X-CRM114-Status: GOOD (  13.19  )
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
Cc: devicetree@vger.kernel.org, Nicolas Boichat <drinkcat@chromium.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, srv_heupstream@mediatek.com,
 kendrick.hsu@mediatek.com, Daoyuan Huang <daoyuan.huang@mediatek.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Jassi Brar <jassisinghbrar@gmail.com>,
 linux-kernel@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>,
 Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>, YT
 Shen <yt.shen@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Houlong Wei <houlong.wei@mediatek.com>,
 Sascha Hauer <kernel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
 Frederic Chen <Frederic.Chen@mediatek.com>,
 linux-arm-kernel@lists.infradead.org, ginny.chen@mediatek.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi, Bibby:

I would like to add the prefix 'cmdq' in the commit title so that we
could understand that this patch is applied to cmdq not pwrap.

Regards,
CK


On Tue, 2019-01-29 at 15:31 +0800, Bibby Hsieh wrote:
> add mt8183 compatible name
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> index 2281178..909eb23 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -536,6 +536,7 @@ static int cmdq_probe(struct platform_device *pdev)
>  
>  static const struct of_device_id cmdq_of_ids[] = {
>  	{.compatible = "mediatek,mt8173-gce", .data = (void *)16},
> +	{.compatible = "mediatek,mt8183-gce", .data = (void *)24},
>  	{}
>  };
>  



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
