Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF5AC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:48:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77A7B218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W9q8O6Im"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A7B218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v2gWp1uUNxlO0odcu/oYmZgfadNg+UIL0nANr2jT39k=; b=W9q8O6ImAtpalQ
	JChLJQzGsiIecYbxDOdH3YwGJfA1mbzyJ7KKOJjeRmH5bJrqmoQLb0rbqpCN2FvlmMd6FL1GEZ4fU
	HLlUxslzv+gop1cm9IbIS01ildNLpxDKPdxzoD/3dOgI3rJcXVaP/9KO2BNrRzgTAnJYvQsqoZXK8
	BCXnqRx/mk1Ydu/ToLh0HaiHRa7eCCIdpQIoUeqYe9teKnywqpdH9WPD7v7tgui2UdwjmyO7WzCnR
	fFKIZK1YpPmkpa164f8kyqCJammUqRuVGijvTFvkF8jIuGrtavYd/ER66mFAUk/oIMEyFBnIc73im
	1T5IpXZ86WDtpT0JkHyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmlvX-0006EB-Ph; Thu, 24 Jan 2019 20:48:43 +0000
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]
 helo=smtp.smtpout.orange.fr)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmlvT-0006Dj-0p
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 20:48:41 +0000
Received: from belgarion ([86.206.19.74]) by mwinf5d65 with ME
 id ULoa1z00F1btlZA03LobGZ; Thu, 24 Jan 2019 21:48:36 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Thu, 24 Jan 2019 21:48:36 +0100
X-ME-IP: 86.206.19.74
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH] ARM: pxa: remove unused empty mach/pxa25x-udc.h file
References: <20190124160222.13138-1-vz@mleia.com>
X-URL: http://belgarath.falguerolles.org/
Date: Thu, 24 Jan 2019 21:48:34 +0100
In-Reply-To: <20190124160222.13138-1-vz@mleia.com> (Vladimir Zapolskiy's
 message of "Thu, 24 Jan 2019 18:02:22 +0200")
Message-ID: <87ef91wzml.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_124839_433519_89EB4424 
X-CRM114-Status: GOOD (  13.30  )
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
Cc: linux-arm-kernel@lists.infradead.org,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>,
 Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Vladimir Zapolskiy <vz@mleia.com> writes:

> Commit c5418a0b98c1 ("usb: gadget: pxa25x_udc: move register definitions
> from arch") removed inclusion of mach/pxa25x-udc.h from the PXA25x UDC
> driver, the contents of the header file was also wiped out, however the
> file itself hasn't been removed, now this change removes the unused empty
> header file.
>
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Queued to pxa/for-next, thanks.

Cheers.

-- 
Robert

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
