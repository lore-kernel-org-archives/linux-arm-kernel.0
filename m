Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAB0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:10:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46ECD21841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LPWovidU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46ECD21841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J1xl2oWg5QJGee+DQG3a+wcqQXuqLBIgkABfrEJ7W20=; b=LPWovidUdq+kAb
	3/jvyMs5ItW3K2+y4WLCFjnUb4Df2mm1lbT3/yQA+iIARX3eo9K83C7WROy83r1Clq6YggNN6AMAV
	D7aX62tybo4aJftgKke3uZkqg/0UMugUaT9qAa5/F1vUffSL5R7uXVbBB3K+snfQTP4uEuGy0Q3UL
	8u4zadweWXNhEsg+lj1EO3e+jd6ym3SaR5kZZS3ILM7398S7wGdMb2pgC6CQdVo1MMybSBkeUGAV+
	J9xMHOKU+gOeCGpzVVb+NHxpG3OJ0Dr0v/MDvrlBMs41egz0EjdKt7ETIijlVL52N6BQeSth6k9lu
	DNGHLMuE8YamdDjbiP3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZHwm-0003Vd-5w; Tue, 18 Dec 2018 16:10:16 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZHwd-0002Cf-Hf
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 16:10:13 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 190E220BE1; Tue, 18 Dec 2018 17:09:56 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
 by mail.bootlin.com (Postfix) with ESMTPSA id DEBE32072C;
 Tue, 18 Dec 2018 17:09:45 +0100 (CET)
Date: Tue, 18 Dec 2018 17:09:45 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [RESEND PATCH v2] MAINTAINERS: Add a maintainer for MSCC MIPS SoCs
Message-ID: <20181218160945.GF19816@piout.net>
References: <20181218160750.6766-1-alexandre.belloni@bootlin.com>
 <20181218160750.6766-2-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181218160750.6766-2-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_081007_743785_F9E306CE 
X-CRM114-Status: GOOD (  12.29  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Please ignore this, it was meant for the MIPS maintainers.

On 18/12/2018 17:07:47+0100, Alexandre Belloni wrote:
> Microsemi has been bought by Microchip and Microchip is supporting those
> SoCs.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f4855974f325..50223cba6ddb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9801,8 +9801,9 @@ F:	drivers/dma/at_xdmac.c
>  
>  MICROSEMI MIPS SOCS
>  M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
> +M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
>  L:	linux-mips@linux-mips.org
> -S:	Maintained
> +S:	Supported
>  F:	arch/mips/generic/board-ocelot.c
>  F:	arch/mips/configs/generic/board-ocelot.config
>  F:	arch/mips/boot/dts/mscc/
> -- 
> 2.20.0
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
