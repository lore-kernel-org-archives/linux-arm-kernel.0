Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A008C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:52:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0524920842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W/jDsjsh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0524920842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:
	Subject:To:From:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=r3akcYzuyuWtEq6Acaa1T306NVjzjNtLZSR/ZBP9hzs=; b=W/jDsjshy5HqGa
	jxTKC8afKMxaGBFHFbx0mgycsVdydls7rzxhB4a4SIJcCBQTnItsDm5xfUEyLfm16s7bCPWZcHBiD
	AOkSkDDnBXc4FWlLsqZxcRGZ2gyExUoyORkQgXxpdX7/bOpBWVuAC+57E5vG06SmJFkeh3SA7nDPb
	BDsSJHyyJYu44KdxUVCwuKE+5ySuGjG1xeEv7fE5nk6sP9kU6WYQzUoFg0MfHoeSd4JpcbVCBtWqE
	61FiUNy0m7Afbvx+CClZMd9EJZpMUC5tFq1WFSuUspts6j1yKENZfvtYj/F3Mth3zt8ess2VsWDV1
	wJ18nDCVw9i67VdGirWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz3NT-0005Tq-At; Wed, 27 Feb 2019 17:52:19 +0000
Received: from vmi206558.contaboserver.net ([2a02:c207:2020:6558::1])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz3NQ-0005TK-9W
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 17:52:17 +0000
Received: from vmi206558.contaboserver.net (localhost.localdomain [127.0.0.1])
 by vmi206558.contaboserver.net (Postfix) with SMTP id 2425AE4258F
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 27 Feb 2019 18:30:25 +0100 (CET)
From: linux-arm-kernel@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Subject: Zdravstvujte Vas interesuyut bazy dannyh dlya prodazhi Vashih tovarov
 i uslug?
Message-Id: <20190227173025.2425AE4258F@vmi206558.contaboserver.net>
Date: Wed, 27 Feb 2019 18:30:25 +0100 (CET)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_095216_474577_8C5B9715 
X-CRM114-Status: UNSURE (   2.04  )
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
Reply-To: prodawez@armyspy.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Zdravstvujte Vas interesuyut bazy dannyh dlya prodazhi Vashih tovarov i uslug?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
