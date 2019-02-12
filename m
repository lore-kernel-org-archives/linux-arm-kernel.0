Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95069C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:11:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EDB42082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k1xb3ddO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EDB42082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ffWZTFnhCtGLN9YCdMF3t3qljZ902evgchkhcsdmLuk=; b=k1xb3ddONEtL6Rg9Ax2CE0cza
	sneXqJuPsYOGPHNQaHBdCzYayStZRLynteT1v7QnFz3staTYj7j+DrYN2pYVL5ZPw8VVyWRaklcJU
	wMACpBq84pGdJl1TIFVKz9zm+E0SHtYIMxYML4ch1FP8LO+ZSKJstlASpc2CBvgFB8nrO2UO2mwVu
	W8i1YklYrFXs/KvjDgdma+ooD6Y5YFZKh+sJhOGAqlSaCZaSlBTD+8FD2/H36+Ewz7dVejYRz0ZYo
	TyaF1DdLLdsHF8gTi0FJXsh9we7SVkC4zmFxwcHsraM14+hS1LkxAxG5XZOAhLh6b+3mfgg3EWUmr
	ZKfV35HpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtWun-0006Ga-S9; Tue, 12 Feb 2019 12:11:53 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtWuW-00063r-G2
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 12:11:50 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0D8C80D;
 Tue, 12 Feb 2019 04:11:34 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E50CC3F589;
 Tue, 12 Feb 2019 04:11:32 -0800 (PST)
Subject: Re: [PATCH] KVM: arm/arm64: Update MAINTAINERS entries
To: marc.zyngier@arm.com, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
References: <20190212110648.177490-1-marc.zyngier@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <20cd8297-3d5a-531a-56e9-75d0df57a555@arm.com>
Date: Tue, 12 Feb 2019 12:11:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190212110648.177490-1-marc.zyngier@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_041137_197983_9B7FE4B4 
X-CRM114-Status: GOOD (  15.30  )
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
Cc: james.morse@arm.com, christoffer.dall@arm.com, julien.thierry@arm.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
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
> entry.

Thanks for the recognition !

> 
> Acked-by: Christoffer Dall <christoffer.dall@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   MAINTAINERS | 18 +++++++-----------
>   1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 51029a425dbe..91ec0682443b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8297,29 +8297,25 @@ S:	Maintained
>   F:	arch/x86/include/asm/svm.h
>   F:	arch/x86/kvm/svm.c
>   
> -KERNEL VIRTUAL MACHINE FOR ARM (KVM/arm)
> +KERNEL VIRTUAL MACHINE FOR ARM/ARM64 (KVM/arm, KVM/arm64)
>   M:	Christoffer Dall <christoffer.dall@arm.com>
>   M:	Marc Zyngier <marc.zyngier@arm.com>
> +R:	James Morse <james.morse@arm.com>
> +R:	Julien Thierry <julien.thierry@arm.com>

> +R:	Suzuki Pouloze <suzuki.poulose@arm.com>

Please note that it is: "Suzuki K Poulose"

With that:

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
