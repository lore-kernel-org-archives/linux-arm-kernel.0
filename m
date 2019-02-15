Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590B5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:26:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0881721929
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VLK8wvdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0881721929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=R72gMZuhzcu/PZGSYT/GRm/Mu6pdCptWgDsOMjG2LLI=; b=VLK8wvdwgsg8Ly
	L8gLb6F7u0ntlpAXDzYMMPHotPSTuIR2PM832cHYHWb+rFPFJgdVjEgNlaGpc7cCwVHk5rd/07ARF
	qkBdxD8ZoivaIGnaei3QJvILYU3o1DyIrUj8wcIzJFdArGhZmg5VLm8ZjiL2o+qN7XWh0KNZyRtjR
	EhXImsOGRdDa40MzvQFFbZl4imSDuJLsa3b9CMma9TJFdhB4Ja32DMRlVnGWE6HMw8/N9zrKsA5Fz
	eNZ4R6xpzUMMTvM/4fezSg9nJ6hgDaNoHyjF7/DbjBkbqE6/hGv3FE6U+sGm8W0HkCB8CCxEBuId4
	3ZCzgzAtKqklUnw0pabQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guhFl-00014m-Bw; Fri, 15 Feb 2019 17:26:21 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guhFh-0000zm-4k
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 17:26:18 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD068EBD;
 Fri, 15 Feb 2019 09:26:16 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96CCB3F557;
 Fri, 15 Feb 2019 09:26:15 -0800 (PST)
Subject: Re: [PATCH] KVM: arm/arm64: Update MAINTAINERS entries
To: Marc Zyngier <marc.zyngier@arm.com>
References: <20190212110648.177490-1-marc.zyngier@arm.com>
From: James Morse <james.morse@arm.com>
Message-ID: <a3a433a9-0e28-08ed-c02f-7b241ebb9652@arm.com>
Date: Fri, 15 Feb 2019 17:26:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190212110648.177490-1-marc.zyngier@arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_092617_281248_5C81208E 
X-CRM114-Status: GOOD (  10.94  )
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
Cc: kvm@vger.kernel.org, Julien Thierry <julien.thierry@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Marc,

On 12/02/2019 11:06, Marc Zyngier wrote:
> For historical reasons, KVM/arm and KVM/arm64 have had different
> entries in the MAINTAINER file. This makes little sense, as they are
> maintained together.
> 
> On top of that, we have a bunch of talented people helping with
> the reviewing, and they deserve to be mentionned in the consolidated

(mentioned)

> entry.


> diff --git a/MAINTAINERS b/MAINTAINERS
> index 51029a425dbe..91ec0682443b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8297,29 +8297,25 @@ S:	Maintained
>  F:	arch/x86/include/asm/svm.h
>  F:	arch/x86/kvm/svm.c
>  
> -KERNEL VIRTUAL MACHINE FOR ARM (KVM/arm)
> +KERNEL VIRTUAL MACHINE FOR ARM/ARM64 (KVM/arm, KVM/arm64)
>  M:	Christoffer Dall <christoffer.dall@arm.com>
>  M:	Marc Zyngier <marc.zyngier@arm.com>
> +R:	James Morse <james.morse@arm.com>

Acked-by: James Morse <james.morse@arm.com>


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
