Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6320C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:31:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B09E920863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CqzsKv6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B09E920863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r6bbew6Da6tKlJJ8rZVtzZPbOtk0ZPfCQS64wWJ7bNI=; b=CqzsKv6h4nT3ik
	axplnC7YiX3b8rSZWSKcWNwRPS8lsXbZ4Eyrlq3t20ldeyadGhYTrfkcePxrggRcBqaFhS46b8lwW
	JNQdXvLUIclXlFZjHDpTwyX8wz4rpsrQytPdgdo7tnewR/Aq1aA1X9pkmJIDp2DJXjBlD0BDG0L6n
	l+MM+rYxrqn2R5LpehnG7iBxUfneAxFZ8AVQhLqpY4xUH0uwZyY7X/32f9JQys+3R/ERhQs2E76jE
	dblUi+lOtPqbotqjM6rgtW3YunJ4y5vs/OmsIMWc2JNhUhejc3xiw+Il3svsI+GUL0sSRDF874g5W
	ccgPw4l7chE8ns/Z19KA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gydls-0005vt-RJ; Tue, 26 Feb 2019 14:31:48 +0000
Received: from relay9-d.mail.gandi.net ([217.70.183.199])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gydlp-0005vJ-2H
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 14:31:46 +0000
X-Originating-IP: 90.88.147.150
Received: from aptenodytes (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr
 [90.88.147.150])
 (Authenticated sender: paul.kocialkowski@bootlin.com)
 by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 8B59BFF803;
 Tue, 26 Feb 2019 14:31:38 +0000 (UTC)
Message-ID: <0c47612b429c5055d98e8ec793c1a6abd90bb6c3.camel@bootlin.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: Add vendor prefix for Ronbo
 Electronics
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Sean Paul <seanpaul@chromium.org>
Date: Tue, 26 Feb 2019 15:31:38 +0100
In-Reply-To: <6db67808e9184e25db0577014317e459b6dd2dfe.camel@bootlin.com>
References: <cover.5ac8e6ed5381ceb14a2e5d64671228f665a08d43.1550650810.git-series.maxime.ripard@bootlin.com>
 <a7ab8bd59ad673f88e2c39cf6cb21bd959cf4db4.1550650810.git-series.maxime.ripard@bootlin.com>
 <6db67808e9184e25db0577014317e459b6dd2dfe.camel@bootlin.com>
Organization: Bootlin
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_063145_253579_D9F235E2 
X-CRM114-Status: GOOD (  13.55  )
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
Cc: Konstantin Sudakov <k.sudakov@integrasources.com>, bbrezillon@kernel.org,
 dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2019-02-26 at 15:30 +0100, Paul Kocialkowski wrote:
> Hi,
> 
> On Wed, 2019-02-20 at 09:21 +0100, Maxime Ripard wrote:
> > From: Konstantin Sudakov <k.sudakov@integrasources.com>
> > 
> > Ronbo Electronics manufactures display panels.
> > 
> > Signed-off-by: Konstantin Sudakov <k.sudakov@integrasources.com>
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Ah actually, I went too fast on this one: the vendor is not added
following alphabetical order. With that fixed:

> Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > index 4f225ce815d8..b64d8316dfae 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > @@ -337,6 +337,7 @@ riscv	RISC-V Foundation
> >  rockchip	Fuzhou Rockchip Electronics Co., Ltd
> >  rohm	ROHM Semiconductor Co., Ltd
> >  roofull	Shenzhen Roofull Technology Co, Ltd
> > +ronbo   Ronbo Electronics
> >  samsung	Samsung Semiconductor
> >  samtec	Samtec/Softing company
> >  sancloud	Sancloud Ltd
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
