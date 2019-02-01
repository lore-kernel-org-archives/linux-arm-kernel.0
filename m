Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12088C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:57:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D364D2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u8Kpexjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D364D2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wrnZiDAIZyoDWHVdFbn0vmfhQb8yl4BkhVz9l4LUuK8=; b=u8KpexjyN2irlC
	8pbbq/EGvPxTdoUku00RPXcWPRglL6Ea1RihGvlbI6OOARSKWiv5KWoshh94IXv5cYcIQ/DOcDSbR
	Dvp12GI9nh7CHzl8CuRrdjhgZygAL3cuBrS/aBpjZFSwyzxHdPWUcxfWlA5l4HKdZbporjkITJMnT
	ry0lu1/oFdGV6UHuM4UR575TRRf56m6HTR8Ilf7C1dUa5cE3kXvzghfeevLagN2XIxvixzlMQU9u6
	TANfcpZJTpfH0g1sRFVatguvITbKeUzK9FWnoPZ3LZIJmBY1KrnoLtiaxr00HmqsKfiThyxZPrTvk
	/JfdhXzwUew5AARlrQsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpc7s-0002xd-JM; Fri, 01 Feb 2019 16:57:12 +0000
Received: from lhrrgout.huawei.com ([185.176.76.210] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpc7o-0002uy-LC
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 16:57:10 +0000
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id A29306BFA94FD377B0A8;
 Fri,  1 Feb 2019 16:57:05 +0000 (GMT)
Received: from [127.0.0.1] (10.202.226.46) by LHREML714-CAH.china.huawei.com
 (10.201.108.37) with Microsoft SMTP Server id 14.3.408.0; Fri, 1 Feb 2019
 16:57:02 +0000
Subject: Re: [PATCH] arm64: dts: hi3798cv200: fix malformed SPDX license
 identifier
To: Shawn Guo <shawnguo@kernel.org>
References: <20190118005404.10452-1-shawnguo@kernel.org>
From: Wei Xu <xuwei5@hisilicon.com>
Message-ID: <585b4540-6d51-72c0-730f-9bb6cfefaa85@hisilicon.com>
Date: Fri, 1 Feb 2019 16:57:02 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118005404.10452-1-shawnguo@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_085708_843415_6685247F 
X-CRM114-Status: GOOD (  12.30  )
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
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Shawn,

On 1/18/2019 12:54 AM, Shawn Guo wrote:
> It fixes malformed SPDX license identifier in Hi3798CV200 and Poplar
> DTS, accroding to Documentation/process/license-rules.rst.
> 
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>

Applied to the hisilicon soc dt tree.
Thanks!

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts | 4 +---
>  arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi       | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
> index 32716c96b457..c563d3eb2d98 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
> @@ -1,10 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * DTS File for HiSilicon Poplar Development Board
>   *
>   * Copyright (c) 2016-2017 HiSilicon Technologies Co., Ltd.
> - *
> - * Released under the GPLv2 only.
> - * SPDX-License-Identifier: GPL-2.0
>   */
>  
>  /dts-v1/;
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
> index 7c0fddd7c8cf..13821a0ff524 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
> @@ -1,10 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * DTS File for HiSilicon Hi3798cv200 SoC.
>   *
>   * Copyright (c) 2016-2017 HiSilicon Technologies Co., Ltd.
> - *
> - * Released under the GPLv2 only.
> - * SPDX-License-Identifier: GPL-2.0
>   */
>  
>  #include <dt-bindings/clock/histb-clock.h>
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
