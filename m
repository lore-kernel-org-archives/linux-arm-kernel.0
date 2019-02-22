Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9245C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:50:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D852075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NFF8isis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D852075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YLokrQz+TLyyLG5060lt7IDoHmYMzk2wTdQCO5XwjBo=; b=NFF8isissc2vy8
	Ul+ldQW9QEDvaxl9DQx7Irr59C635Lg8/oTxgte8R8rBckCglnER5XAZ2JajHsT4N9wADE5uhxFTa
	WDSOlIzDugsaoT6RSzHfGBc78czLXAhWRGomDRGRwMNfYo9ezNv7Ui+XITGzUMaXwxiXMJn3s3tLz
	Yh2QVMmYEkP+WfYHD/l8OxMuYbN3uy282JwvCrsO9mR4uRStyLAEvkt7/8KCdcVOd5SMM5IqmFT2o
	JGbYoxBoRcrdbn+o5IZTREgEo1kCWgEgslNIa0EYP2NVdCmzX1p5y8JPyMEiTII2z0UYbn1/rUphu
	7sSolojmbAINWnf2hffQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxJdv-0007dE-89; Fri, 22 Feb 2019 22:50:07 +0000
Received: from smtprelay0225.hostedemail.com ([216.40.44.225]
 helo=smtprelay.hostedemail.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxJds-00070d-6c
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 22:50:05 +0000
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay07.hostedemail.com (Postfix) with ESMTP id 2C039181D3403;
 Fri, 22 Feb 2019 22:49:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: yard23_73894d74bfc5e
X-Filterd-Recvd-Size: 1512
Received: from XPS-9350.home (unknown [47.151.153.53])
 (Authenticated sender: joe@perches.com)
 by omf06.hostedemail.com (Postfix) with ESMTPA;
 Fri, 22 Feb 2019 22:49:53 +0000 (UTC)
Message-ID: <f07d06d04b5a7ac7f1b35cd1217f0840009302a4.camel@perches.com>
Subject: Re: [PATCH v2] MAINTAINERS: Update Ampere email address
From: Joe Perches <joe@perches.com>
To: Khuong Dinh <khuong@os.amperecomputing.com>, 
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, 
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Date: Fri, 22 Feb 2019 14:49:52 -0800
In-Reply-To: <e9b60c35-d8f9-7feb-ee9b-781157c246b6@os.amperecomputing.com>
References: <1548813357-21892-1-git-send-email-khuong@os.amperecomputing.com>
 <e9b60c35-d8f9-7feb-ee9b-781157c246b6@os.amperecomputing.com>
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_145004_315928_4F42CD70 
X-CRM114-Status: UNSURE (   7.20  )
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
Cc: Open Source Submission <patches@amperecomputing.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 2019-02-22 at 22:43 +0000, Khuong Dinh wrote:
>    Do you have any feedback for this?

It's trivial, though it might be nice to describe
in the commit message why specific maintainers are
being changed from one person to another.

If you are not going to send a pull request for it,
send it to 'Andrew Morton <akpm@linux-foundation.org>'
if no one else picks it up.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
