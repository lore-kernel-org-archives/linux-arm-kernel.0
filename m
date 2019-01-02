Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEF2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:41:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE2C6218A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WZi9CV5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2C6218A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UWaNn4JFDjIYYJH7iXSgZ6ZJrNpybh9OqUeznFGl36A=; b=WZi9CV5IEfFqME
	3qoLRoy/T3ZHqQ5vVG22A2A/cS2zhthwPF9mgHD7L8y0wq9kpEbc0z5bKDMCBbiuysUKEGa/9G2jr
	k0Vfs7NRL4n2sygsXmxuxJLfEyw/U81vEw+K52c680pKKRZd8XBh5J/iUCpy6tSdi+o+IRXbB++/G
	J7o0U9sxfXBoGMmMdtlryCGQMiMWmfkiGoUzZrUoYhNvOIvnYYSyB0IGHOT6ZaaH1uxZCLEtc/b+W
	gqMW1HUSnLWq4HIkKj5V2I9qk721r2CUsagtU/gB+ASgxxl43spiW0tpdnhZdWjpWiGycbW156Y+/
	eKoslSnrTFtDA6x5u78Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gedxd-000239-Ol; Wed, 02 Jan 2019 10:41:17 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gedxS-0001vR-EI
 for linux-arm-kernel@lists.infradead.org; Wed, 02 Jan 2019 10:41:09 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EC6EF;
 Wed,  2 Jan 2019 02:41:00 -0800 (PST)
Received: from [10.1.30.136] (e121487-lin.cambridge.arm.com [10.1.30.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EE4D3F575;
 Wed,  2 Jan 2019 02:40:58 -0800 (PST)
Subject: Re: [PATCH] arm/mm/pmsa-v8 : remove unneeded semicolon
To: Peng Hao <peng.hao2@zte.com.cn>, linux@armlinux.org.uk
References: <1545891981-84215-1-git-send-email-peng.hao2@zte.com.cn>
From: Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <8dad8524-b8d1-cb54-0743-68dd3089de8e@arm.com>
Date: Wed, 2 Jan 2019 10:40:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1545891981-84215-1-git-send-email-peng.hao2@zte.com.cn>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_024106_483305_CD9A227A 
X-CRM114-Status: GOOD (  14.63  )
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/27/18 6:26 AM, Peng Hao wrote:
> Remove unneeded semicolon.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  arch/arm/mm/pmsa-v8.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mm/pmsa-v8.c b/arch/arm/mm/pmsa-v8.c
> index 617a83d..0d7d5fb 100644
> --- a/arch/arm/mm/pmsa-v8.c
> +++ b/arch/arm/mm/pmsa-v8.c
> @@ -165,7 +165,7 @@ static int __init pmsav8_setup_ram(unsigned int number, phys_addr_t start,phys_a
>  		return -EINVAL;
>  
>  	bar = start;
> -	lar = (end - 1) & ~(PMSAv8_MINALIGN - 1);;
> +	lar = (end - 1) & ~(PMSAv8_MINALIGN - 1);
>  
>  	bar |= PMSAv8_AP_PL1RW_PL0RW | PMSAv8_RGN_SHARED;
>  	lar |= PMSAv8_LAR_IDX(PMSAv8_RGN_NORMAL) | PMSAv8_LAR_EN;
> @@ -181,7 +181,7 @@ static int __init pmsav8_setup_io(unsigned int number, phys_addr_t start,phys_ad
>  		return -EINVAL;
>  
>  	bar = start;
> -	lar = (end - 1) & ~(PMSAv8_MINALIGN - 1);;
> +	lar = (end - 1) & ~(PMSAv8_MINALIGN - 1);
>  
>  	bar |= PMSAv8_AP_PL1RW_PL0RW | PMSAv8_RGN_SHARED | PMSAv8_BAR_XN;
>  	lar |= PMSAv8_LAR_IDX(PMSAv8_RGN_DEVICE_nGnRnE) | PMSAv8_LAR_EN;
> 

Acked-by: Vladimir Murzin <vladimir.murzin@arm.com>

You need to drop it into Russell's patch system [1]

[1] http://www.armlinux.org.uk/developer/patches/

Cheers
Vladimir

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
