Return-Path: <SRS0=AJAW=PJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE8EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 16:57:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28ED7205F4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 16:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TIykfJCP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28ED7205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OcWPoQpzO2OJGxT3c3vWrRVz+Vg6FupW09H+s4fgbPI=; b=TIykfJCPA5PtfD
	0t9H93LVtxS3Qe2wLZAqZV5t0LdFJns6lr06BDjc0xNUIVckAQLoWVIMtcMM9DIFMyTMIHAXKTnpq
	bVS6IFJiP4v+aPFEYFMWqY+9GUPWal1PuSKs0oFe+TeamqHkXH7Xa9H1HlGWitromd/R6km0ZHbzp
	nvj1IFTEpumeJhKXv2rc5hevH7or0twIBgux3p3brV6Y5f72n1zASRZPSiu/uQmUX61zAiMBtnz3c
	1rW/hlspMkHQf5b8S6rVlP0jbvP7CR6mgIJdhcAsQwTHdeqPJjepNWNpcCjk1WeT7g9mIIgZBeh2f
	joQki8JfEv7bugSGY2Hw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1geNLo-0003Oa-AG; Tue, 01 Jan 2019 16:57:08 +0000
Received: from smtprelay0148.hostedemail.com ([216.40.44.148]
 helo=smtprelay.hostedemail.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1geNLj-0003NH-RY; Tue, 01 Jan 2019 16:57:05 +0000
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay08.hostedemail.com (Postfix) with ESMTP id 24FAA182CF666;
 Tue,  1 Jan 2019 16:56:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: skin36_75f2ef0090321
X-Filterd-Recvd-Size: 3254
Received: from XPS-9350.home (unknown [47.151.153.53])
 (Authenticated sender: joe@perches.com)
 by omf03.hostedemail.com (Postfix) with ESMTPA;
 Tue,  1 Jan 2019 16:56:50 +0000 (UTC)
Message-ID: <a935ceb348e5b4efb754484da745425afa1e7713.camel@perches.com>
Subject: Re: [PATCH 6/6] MAINTAINERS: Add linux-actions mailing list for
 Actions Semi
From: Joe Perches <joe@perches.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Tue, 01 Jan 2019 08:56:49 -0800
In-Reply-To: <20190101032622.GC2736@Mani-XPS-13-9360>
References: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
 <20181231185517.18517-7-manivannan.sadhasivam@linaro.org>
 <2a7f53c58896e2a9c3115a8630040b98497e5877.camel@perches.com>
 <20190101032622.GC2736@Mani-XPS-13-9360>
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190101_085704_026493_087C93AF 
X-CRM114-Status: GOOD (  12.89  )
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
Cc: devicetree@vger.kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
 linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, robh+dt@kernel.org, afaerber@suse.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2019-01-01 at 08:56 +0530, Manivannan Sadhasivam wrote:
> Hi Joe,

Hi Manivannan.

> On Mon, Dec 31, 2018 at 11:12:18AM -0800, Joe Perches wrote:
> > On Tue, 2019-01-01 at 00:25 +0530, Manivannan Sadhasivam wrote:
> > > Add the linux-actions mailing list for Actions Semi SoC architecture.
> > =

> > Unrelated to adding this L: entry
> > =

> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > []
> > > @@ -1240,6 +1240,7 @@ ARM/ACTIONS SEMI ARCHITECTURE
> > >  M:	Andreas F=E4rber <afaerber@suse.de>
> > >  R:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > >  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribe=
rs)
> > > +L:	linux-actions@lists.infradead.org (moderated for non-subscribers)
> > >  S:	Maintained
> > >  N:	owl
> > =

> > The N: entry matches too many non-owl entries like:
> > =

> > Documentation/parport-lowlevel.txt
> > drivers/misc/ibmasm/lowlevel.c
> > drivers/misc/ibmasm/lowlevel.h
> > fs/udf/lowlevel.c
> > net/ipv6/ip6_flowlabel.c
> > sound/soc/samsung/lowland.c
> > =

> > Maybe there should be two entries
> > =

> > N:	/owl
> > N:	-owl
> > =

> =

> Thanks for letting us know. Yes, we need to change it. How about below?
> =

> N: owl-
> N: -owl
> =

> Will do it as a follow-up patch if agreed!

from MAINTAINERS:

	   scripts/get_maintainer.pl has different behavior for files that
	   match F: pattern and matches of N: patterns.  By default,
	   get_maintainer will not look at git log history when an F: pattern
	   match occurs.  When an N: match occurs, git log history is used
	   to also notify the people that have git commit signatures.

F: entries are preferred to N: entries because the
get_maintainer.pl script does not assume that the
N: entries are exclusively maintained.  Maybe use a
more comprehensive F: list like:

F:	Documentation/devicetree/bindings/*/*owl-*
F:	arch/arm/boot/dts/owl-*
F:	drivers/*/owl-*
F:	drivers/*/*-owl*
F:	drivers/*/*/owl-*
F:	drivers/*/*/*-owl*
F:	include/dt-bindings/power/owl-*
F:	include/linux/soc/actions/owl-sps.h



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
