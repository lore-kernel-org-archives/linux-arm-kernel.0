Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8C3C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:46:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A40F21855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VpZN3E8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A40F21855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qCZ7cJFlcFoV4gl8p4fT/1cXSubJ5gcZEVWCiDvLNjw=; b=VpZN3E8OAkq9ie
	mXImGx30yDehLk1P2+TKmiX/9G8BRAGaoLUTlnpwMY4a+Hba/bbUKGNIAaV/FBKDDY8Ik8wFxlIG3
	vXtsa+d9n2KgXhaXkCkyzetFLrRoI6j8L2FuR196dUKzgOJv/oshm4aHlMhx3bkPW3Qbe2KoAt+1w
	HClqDyU7MhMdldd6eWRRORPz2zyPoIuSbLhcSin2XByDqlVeGDbyc5jGId4NOMA0w/1TvhosJUa+s
	WEeR3+4Hx3zzqqZ8IiXDAa0bnSZLTG+HsOIx7VdKBVk0oMpMNW7kefybsQLlsUZS2o+YDfT3BA9DP
	xE6FG/5rfFFEroiuQs6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmMbJ-0004ye-Op; Wed, 23 Jan 2019 17:46:09 +0000
Received: from smtprelay0140.hostedemail.com ([216.40.44.140]
 helo=smtprelay.hostedemail.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmMbF-0004xr-IY; Wed, 23 Jan 2019 17:46:07 +0000
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay05.hostedemail.com (Postfix) with ESMTP id 0AA4A1803BBD2;
 Wed, 23 Jan 2019 17:45:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hook98_50c7cd4ae7c16
X-Filterd-Recvd-Size: 3265
Received: from XPS-9350.home (unknown [47.151.153.53])
 (Authenticated sender: joe@perches.com)
 by omf01.hostedemail.com (Postfix) with ESMTPA;
 Wed, 23 Jan 2019 17:45:54 +0000 (UTC)
Message-ID: <b51b1d3071aec95915d48159c1dd6e0a336cd9f4.camel@perches.com>
Subject: Re: [PATCH] staging: mt7621-pinctrl: Remove space after cast
From: Joe Perches <joe@perches.com>
To: Nishad Kamdar <nishadkamdar@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Date: Wed, 23 Jan 2019 09:45:53 -0800
In-Reply-To: <20190123163122.GA4807@nishad>
References: <20190123163122.GA4807@nishad>
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_094605_731511_22B09555 
X-CRM114-Status: GOOD (  16.75  )
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
Cc: devel@driverdev.osuosl.org, Kees Cook <keescook@chromium.org>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 linux-kernel@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-mediatek@lists.infradead.org, NeilBrown <neil@brown.name>,
 linux-arm-kernel@lists.infradead.org, John Crispin <blogic@openwrt.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 2019-01-23 at 22:01 +0530, Nishad Kamdar wrote:
> This patch removes space after a cast as it
> is not needed.
> Issue found by checkpatch.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
>  drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
> index 80e7067cfb79..3e959fa73703 100644
> --- a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
> +++ b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
> @@ -363,7 +363,7 @@ static int rt2880_pinmux_probe(struct platform_device *pdev)
>  		}
>  
>  		range = devm_kzalloc(p->dev, sizeof(*range) + 4, GFP_KERNEL);
> -		range->name = name = (char *) &range[1];
> +		range->name = name = (char *)&range[1];
>  		sprintf(name, "pio");

I find this code unsightly and fragile.
It doesn't test the return of devm_kzalloc for failure.

This might as well be
---
 drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
index 80e7067cfb79..9b52d44abef1 100644
--- a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
+++ b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
@@ -350,7 +350,6 @@ static int rt2880_pinmux_probe(struct platform_device *pdev)
 	for_each_compatible_node(np, NULL, "ralink,rt2880-gpio") {
 		const __be32 *ngpio, *gpiobase;
 		struct pinctrl_gpio_range *range;
-		char *name;
 
 		if (!of_device_is_available(np))
 			continue;
@@ -362,9 +361,10 @@ static int rt2880_pinmux_probe(struct platform_device *pdev)
 			return -EINVAL;
 		}
 
-		range = devm_kzalloc(p->dev, sizeof(*range) + 4, GFP_KERNEL);
-		range->name = name = (char *) &range[1];
-		sprintf(name, "pio");
+		range = devm_kzalloc(p->dev, sizeof(*range), GFP_KERNEL);
+		if (!range)
+			return -ENOMEM;
+		range->name = "pio";
 		range->npins = __be32_to_cpu(*ngpio);
 		range->base = __be32_to_cpu(*gpiobase);
 		range->pin_base = range->base;
	
	


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
