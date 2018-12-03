Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A912C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:31:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28DB920672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D7zvFJ7K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28DB920672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BOCMpYzm8PzwKJfLWojj7H3yKUdxEAi4L8MT/KY8sXE=; b=D7zvFJ7KFiOaUf
	o6WDyfkdSmK+nAmQCD603kmv/I6EU73O2Ko/lGhmwh8AboTCocu8HkCfNxMHS6CbQfVaM1EA+m6jM
	MvnQCUTPNpi+k+ItjZ4zWmcOSeijG/NlslVmv+4xqUlBuCdzZG73DfbdSsGrs0muAom6jLjm/Wtgf
	vf3Aa2R5HRyioRG129K3p++ohsZ8NY4CJeKySS03EfD+h+WcxX5eyhdLxveOZz0wF7ONnQFdU5eHj
	AO494q3Js2z3dJzaXZ/Z+D1HX2/LUmAme7/ni4hqrsejJmz2LzRYBlIhrcpWv6zpp9lG0w9ZRVWac
	yNF9WFjK8c02be7D/q+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTvoR-0001kp-4F; Mon, 03 Dec 2018 21:31:31 +0000
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]
 helo=smtp.smtpout.orange.fr)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvoN-0001jy-W3
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:31:29 +0000
Received: from belgarion ([90.89.234.36]) by mwinf5d89 with ME
 id 7ZXA1z0030nnJME03ZXAfU; Mon, 03 Dec 2018 22:31:13 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Mon, 03 Dec 2018 22:31:13 +0100
X-ME-IP: 90.89.234.36
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 7/7 v2] ARM: dts: pxa3xx: Add Raumfeld DTS files
References: <20181130175543.32628-1-daniel@zonque.org>
 <20181130175543.32628-8-daniel@zonque.org>
X-URL: http://belgarath.falguerolles.org/
Date: Mon, 03 Dec 2018 22:31:10 +0100
In-Reply-To: <20181130175543.32628-8-daniel@zonque.org> (Daniel Mack's message
 of "Fri, 30 Nov 2018 18:55:43 +0100")
Message-ID: <874lbuwb4x.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_133128_311717_F620DC6B 
X-CRM114-Status: GOOD (  14.95  )
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
Cc: devicetree@vger.kernel.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, haojian.zhuang@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Daniel Mack <daniel@zonque.org> writes:

> This patch adds a set of DTS files that support all PXA3xx based Raumfeld
> audio hardware devices.
>
> Common nodes are factored out into 'common' and 'tuneable-clock' include
> files to keep the top-level DTS files smaller.
>
> Signed-off-by: Daniel Mack <daniel@zonque.org>
Queued into pxa/dt, thanks.

Cheers.

--
Robert

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
