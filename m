Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288AAC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:03:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3AC420870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mwnGqyUE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmmsGW5/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3AC420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o3+LCvClpd1lLqnZ0vVBEGu3+yqr8yS84LydoPPxjd4=; b=mwnGqyUES64xkI
	GP9jtB+7ERoHcmHx08pa1V4D26aU0W+Kv8BAGTkIbEFfqLeg1CW9N07cmwZ5KXbTdmqGXkWDLo6ii
	BXtfQpGm9NfFsERyMAF8O2/AGw2eCNCzW3WgU0WajlaY1u3waE9vZ9rrMcaxvCKW8dT5UPOFnr+yW
	nw9UKGy/7La9r4xoTBEeQb1m2oQqzhoMaj8L4pmkV4shcryjbq8zjIJxr9iJUhRa/u5y8bxAkHNaY
	Bo2stWlzgUn0+xh5LoPcrYdzRzh6BqHHiWY8UZcx75Pk+kO7oYtwJcd+k3XOOgkKZ97DkaXzPbMj+
	Elhds3vX5eul9CFLy2eQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glp9t-0001m2-HV; Tue, 22 Jan 2019 06:03:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glp9r-0001ll-28
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 06:03:36 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3636C20870;
 Tue, 22 Jan 2019 06:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548137014;
 bh=V9pzJ6t0jN4VqEBMjpGETQtcLl9+ki4ZEgSZYeeQdk8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KmmsGW5/aFytH4RUZ2ep5/DESpG1HvK+74N2tym+2mPaYV5vfmm4ZUmhUHQcut8vX
 SPZNgd5SIb8mr1s07Uo9+NA/ETU3KNJMrvDLMZVwpEY7A+ge2njg1yAUfCUBQ3ZSaL
 xI79hcllwrGQlqlKbs7UOTsWIEgib6y4HHEimq6M=
Date: Tue, 22 Jan 2019 14:02:56 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: imx: Change Fabio's email address
Message-ID: <20190122060255.GC19929@dragon>
References: <20190121161526.30172-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190121161526.30172-1-festevam@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_220335_116968_D121397B 
X-CRM114-Status: UNSURE (   6.36  )
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
Cc: linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 02:15:26PM -0200, Fabio Estevam wrote:
> I prefer to use my personal email address for kernel related work.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
