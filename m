Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA11C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:45:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B39A5206A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dq64Ul99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B39A5206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y3u4zVQyNAz382Dt3ngBSUbhsANd4aWDjNEqZzd5gYs=; b=Dq64Ul994ZJncN
	mLn0cSqBj0cYItk59IogAhN+gNy4IbL+myBgbC+XcSJ/HhA7EnuQCSvO526JoTZUYxLnoAGfwKY05
	/qKDolldfjpT5ty65a9QSgEmXh1IiVb96PU164WIgrfQV1/ht6iFO0xFnXzm3pLFjzePeCrKpH7LT
	NUQep5RYKDT55aTDbeoEw9YdPMe/ZH7nEBkuSWQ3qc0GRvXXLG0wRTZf5VWV76nQfHXvNzsCaU633
	Ufu6msLhuT7HcrwHH8c5NvmJ6ffwVJMgvZU9oHOLYnIlAROXtgYjzPIk/oTIbT5uNtOcMgpFq2zOm
	uR8LCIPwwLJV/mk6O+PQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYrLB-0004y2-2K; Mon, 17 Dec 2018 11:45:41 +0000
Received: from cloudserver094114.home.pl ([79.96.170.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYrL5-0004pc-Nm
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 11:45:38 +0000
Received: from 79.184.255.25.ipv4.supernova.orange.pl (79.184.255.25) (HELO
 aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 5dbba30557b0cf73; Mon, 17 Dec 2018 12:45:23 +0100
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] PM / AVS: SmartReflex: Switch to SPDX Licence ID
Date: Mon, 17 Dec 2018 12:45:00 +0100
Message-ID: <16983102.8iQ2gmYz8v@aspire.rjw.lan>
In-Reply-To: <7h4lbkue6p.fsf@baylibre.com>
References: <20181208160042.32587-1-nm@ti.com> <7h4lbkue6p.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_034535_928029_F625A870 
X-CRM114-Status: UNSURE (   6.06  )
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
Cc: Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 Kevin Hilman <khilman@kernel.org>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tuesday, December 11, 2018 7:10:54 PM CET Kevin Hilman wrote:
> Nishanth Menon <nm@ti.com> writes:
> 
> > Fix up licensing to be inline with Linux conventions.
> >
> > Reported-by: Rafael J. Wysocki <rafael@kernel.org>
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> 
> Acked-by: Kevin Hilman <khilman@baylibre.com>
> 

Patch applied, thanks!



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
