Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398A9C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:33:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA7ED218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OVYCWvR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7ED218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Th+obbQ5AFkPXHzNwG0A4fTC5bNVrIEQV3SCEPIERuY=; b=OVYCWvR9hU+Hxq
	BBP+jQTrT+k/5ZVhNamT3yt7HhXaYWbrp9XhNrcCmNXI7bFHWX/IkcHppF5lcl9s4LwmTk39Iabk5
	U0E1i8Oee8F50og8TDS4OU5s5YEWXnTqMlrM7H3HiaW8i5LfMJDFoEnTMK4KnQAWy0+Y+pyehKVwV
	tsQvgJNBVnb3z4JPAy/+d7sSZLzCn8vbA80G+xgtQjeP89BG5wcT9369ZpRBDPlbemc3s7c4ny4UW
	yEZLNeyI5G8XpD4qoIsUDwJ9p9LAW6WcNG56iU2jLM0ydAiI4Fb5WIuTZDkSeGjr8DEk4D48Qa9cD
	NsldlfodSwp2Y94WHT2Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gowYC-0006UI-0S; Wed, 30 Jan 2019 20:33:36 +0000
Received: from mleia.com ([178.79.152.223] helo=mail.mleia.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gowY9-0006Tr-BU
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 20:33:35 +0000
Received: from mail.mleia.com (localhost [127.0.0.1])
 by mail.mleia.com (Postfix) with ESMTP id 1276043F69E;
 Wed, 30 Jan 2019 20:33:30 +0000 (GMT)
Subject: Re: [PATCH 06/13] ARM: dts: lpc32xx: remove inclusion of deprecated
 skeleton.dtsi
From: Vladimir Zapolskiy <vz@mleia.com>
To: Sylvain Lemieux <slemieux.tyco@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>
References: <20190129192049.11223-1-vz@mleia.com>
 <20190129192049.11223-7-vz@mleia.com>
Message-ID: <66feef3c-1116-a853-e8ba-317e497c7dea@mleia.com>
Date: Wed, 30 Jan 2019 22:33:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190129192049.11223-7-vz@mleia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190130_203330_096809_FA03E4A6 
X-CRM114-Status: UNSURE (   6.72  )
X-CRM114-Notice: Please train this message. 
/bin/ln: failed to access
 'reaver_cache/texts/20190130_203330_096809_FA03E4A6': No such file or
 directory
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_203330_096809_FA03E4A6 
X-CRM114-Status: GOOD (  10.92  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 01/29/2019 09:20 PM, Vladimir Zapolskiy wrote:
> Inclusion of skeleton.dtsi into DTS files is deprecated since
> commit 9c0da3cc61f1233c ("ARM: dts: explicitly mark skeleton.dtsi
> as deprecated").
> 

This change will be dropped to avoid a conflict with a functionally
equal applied change from Rob.

--
Best wishes,
Vladimir

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
