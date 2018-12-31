Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61514C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 19:12:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E5112081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 19:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a8IIxvke"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E5112081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mJ+MF4UShCZUTNAOhlt3LfR9NIbyMUnvOKWGJeaWv+s=; b=a8IIxvke1dkNYa
	ls465DKWyre0OWEkhILhlQcAF3u9aYNTqSC3GDJvw9nMSHzPzusmWZ4YXWduO12ZsmB8PJ2s9qysg
	CbdIjdhQr89EQQsqjt1xlUFnYK+mo57DGXzxpX7m/FAnUXz+WxJm78DLYiufpuETckrDHDRyZ9T6X
	fOLlubisJqRYVol8rH3dw9ooqXIQ3A6ST/a+zqKdQDCIjg7neqLH5TZKxZ6S6HnIrB/0vFV+TA7fl
	+v1zoyKVY8otS6AoMW5ZphUQiGwUcbpNTRS5DUAQixJaysM7ydbwll1AbkATWbXCPTEUya9va+/OR
	QXTwFFhrPR/rjnlIrvbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ge2zJ-0002hx-FU; Mon, 31 Dec 2018 19:12:33 +0000
Received: from smtprelay0141.hostedemail.com ([216.40.44.141]
 helo=smtprelay.hostedemail.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ge2zG-0002hA-5r; Mon, 31 Dec 2018 19:12:31 +0000
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay01.hostedemail.com (Postfix) with ESMTP id 9790B100E86C1;
 Mon, 31 Dec 2018 19:12:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: spade09_4e8ff7f567408
X-Filterd-Recvd-Size: 1943
Received: from XPS-9350.home (unknown [47.151.153.53])
 (Authenticated sender: joe@perches.com)
 by omf01.hostedemail.com (Postfix) with ESMTPA;
 Mon, 31 Dec 2018 19:12:19 +0000 (UTC)
Message-ID: <2a7f53c58896e2a9c3115a8630040b98497e5877.camel@perches.com>
Subject: Re: [PATCH 6/6] MAINTAINERS: Add linux-actions mailing list for
 Actions Semi
From: Joe Perches <joe@perches.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 sboyd@kernel.org, mturquette@baylibre.com, afaerber@suse.de,
 robh+dt@kernel.org
Date: Mon, 31 Dec 2018 11:12:18 -0800
In-Reply-To: <20181231185517.18517-7-manivannan.sadhasivam@linaro.org>
References: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
 <20181231185517.18517-7-manivannan.sadhasivam@linaro.org>
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_111230_279481_A5A5AE9E 
X-CRM114-Status: UNSURE (   6.11  )
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
Cc: devicetree@vger.kernel.org, linux-actions@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2019-01-01 at 00:25 +0530, Manivannan Sadhasivam wrote:
> Add the linux-actions mailing list for Actions Semi SoC architecture.

Unrelated to adding this L: entry

> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -1240,6 +1240,7 @@ ARM/ACTIONS SEMI ARCHITECTURE
>  M:	Andreas F=E4rber <afaerber@suse.de>
>  R:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +L:	linux-actions@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  N:	owl

The N: entry matches too many non-owl entries like:

Documentation/parport-lowlevel.txt
drivers/misc/ibmasm/lowlevel.c
drivers/misc/ibmasm/lowlevel.h
fs/udf/lowle
vel.c
net/ipv6/ip6_flowlabel.c
sound/soc/samsung/lowland.c

Maybe there should be two entries

N:	/owl
N:	-owl



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
