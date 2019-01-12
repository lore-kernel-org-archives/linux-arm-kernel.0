Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C016CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 03:09:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B1D82177B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 03:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hVGS813X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1D82177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JlDefswrzHXOBkccy5ec8N1iaQiKxH5uszWAD/MR/24=; b=hVGS813XGYLGsx
	Ax7Rxfs0tgH/6lfnw+/NO+wbOXLpV0WeKnWEm+JqlymNUBn/Fp9gcRZcLARCk6FiRnZHoRdZ35oHD
	GDFA8TQb3uCGjzOZe7N6AjwcA8Itl61NiHp1qnoSDiCGkagxS4baeiBYtLYhd0QIQZ4KRNOQyMarc
	gQxqMK5AuMQBa+6TVorYJmgtge1iASo5l8syGVfdg2O4zbV6jd5f3GEPr8bagx5M2qrc9zobuNHFV
	t320zvgEkutz0K6Xy9SZTVsnwW2Lrsxlpu60vJ5IIsJbIH+JENCl8VtBCLoZM5JFQ4w6Z5sNMJGDj
	mspiJCrS3KAzkpAevNzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi9fn-0003pP-Tp; Sat, 12 Jan 2019 03:09:23 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi9fh-0003dK-Cb
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 03:09:20 +0000
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 06CE0695A1821037ED7C;
 Sat, 12 Jan 2019 11:09:08 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Sat, 12 Jan 2019
 11:09:03 +0800
Subject: Re: [PATCH] MAINTAINERS: Add LAKML list to ACPI for ARM64 entry
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 <linux-arm-kernel@lists.infradead.org>
References: <20190111120419.10775-1-lorenzo.pieralisi@arm.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <f09ae895-e3be-b3d1-1f78-e6637df72d84@huawei.com>
Date: Sat, 12 Jan 2019 11:08:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20190111120419.10775-1-lorenzo.pieralisi@arm.com>
Content-Language: en-US
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_190918_168910_C8898D09 
X-CRM114-Status: GOOD (  11.14  )
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
Cc: Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Hanjun
 Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2019/1/11 20:04, Lorenzo Pieralisi wrote:
> Patches for ACPI for ARM64 must be posted and reviewed on the Linux
> ARM kernel mailing list (in addition to linux-acpi@vger) since they
> affect (and are merged through) the ARM64 tree.
> 
> Make this explicit.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
