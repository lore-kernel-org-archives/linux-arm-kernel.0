Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0466EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 01:22:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD77220855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 01:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LLrLVdhg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="beBa0qFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD77220855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fi/jYAgMdnjZBC/9HFivtqKu5nc1JXkqidE37Ksjipc=; b=LLrLVdhgWibX6s
	nmsL13IfFgcmw6v2JQxutnb6ECMdhFLQX0BDhmWfVTOPJ6b40KqBnhdJq5gnlQmkEUxQMKulLq/vc
	Jr5C7wDNQzd8zGAItAKomieZ92tN1h3HvxImCbTxiv15XBQdZtSEaNFZnF46iMyStRSdh4I2yHHx6
	gfyHFfpbACe5p/x3HfXz9kwwjfW+ZkyICLx0R0UlbOYk0+hXhxAwqQFoBDnijElhOsjeOdekOkOIt
	PnriCiYnXazcwPLVdfjwCCfeR6UkhNjC2Q9RqVtAqkGluP+DTkIidj1s0T6678cgm+C1IcupSP+23
	gHfss5c5UDsz0r3iZZbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvXdy-0006q1-53; Mon, 18 Feb 2019 01:22:50 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvXdu-0006pD-97
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 01:22:47 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 024FD20855;
 Mon, 18 Feb 2019 01:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550452966;
 bh=KGMVlGPDog11LRbGy+wgyYjX7sW2H8y3CKYMJviq5fQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=beBa0qFHNhNdbgGBdn3vpvawlQWbX0cjkS+711qPyFBCbu7Hk2gvQl0idGbrQmU+X
 BoD2kjJElClJT+TSO3DHK5oRnFVBI1IohUdvbQuD6uMS6MVNMBYd9SjojPAEPXpOsx
 9RAUNGMjRnKjNTo52TeVlFjAh2GX5oFeDsipTgBo=
Date: Mon, 18 Feb 2019 09:22:16 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH V4 4/4] MAINTAINERS: Added imx DDR performonitor driver
 maintainer information
Message-ID: <20190218012215.GB6262@dragon>
References: <1550253761-26841-1-git-send-email-Frank.Li@nxp.com>
 <1550253761-26841-4-git-send-email-Frank.Li@nxp.com>
 <20190215200141.pncrzp3oaoja2mnd@pengutronix.de>
 <CAHrpEqTexakw-OXjUt3nTdroPxv2YVjT-8VmZTUpDeF6e_dZMw@mail.gmail.com>
 <20190215214444.n2watl6k5ij6ptfs@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190215214444.n2watl6k5ij6ptfs@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_172246_358951_EE438CF6 
X-CRM114-Status: GOOD (  17.73  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 Aisheng Dong <aisheng.dong@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, Frank Li <frank.li@nxp.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>, Zhi Li <lznuaa@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 10:44:44PM +0100, Uwe Kleine-K=F6nig wrote:
> On Fri, Feb 15, 2019 at 03:13:00PM -0600, Zhi Li wrote:
> > On Fri, Feb 15, 2019 at 2:01 PM Uwe Kleine-K=F6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > >
> > > On Fri, Feb 15, 2019 at 06:03:16PM +0000, Frank Li wrote:
> > > > Add DDR perf counter driver maintainer information
> > > >
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > > No change from v1 to v4
> > > >
> > > >  MAINTAINERS | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 6ba068e..687be0f 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -6163,6 +6163,13 @@ L:     linux-i2c@vger.kernel.org
> > > >  S:   Maintained
> > > >  F:   drivers/i2c/busses/i2c-cpm.c
> > > >
> > > > +FREESCALE IMX DDR Performance Monitor DRIVER
> > > > +M:   Frank Li <Frank.li@nxp.com>
> > > > +L:   linux-arm-kernel@lists.infradead.org
> > > > +S:   Maintained
> > > > +F:   drivers/perf/fsl_imx8_ddr_perf.c
> > > > +F:   Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
> > > > +
> > >
> > > With da8b7f0fb02b ("MAINTAINERS: add all files matching "imx" and "mx=
s"
> > > to the IMX entry") that sits currently in next the "ARM/FREESCALE IMX=
 /
> > > MXC ARM ARCHITECTURE" also matches for these two files.
> > >
> > > Is this good here or not?
> > =

> > Yes! what's do you means?
> > Needn't these entry because da8b7f0fb02b?
> =

> It's just that we then will have two entries that will match. In a tree
> where I have both, this series and da8b7f0fb02b I see:
> =

> 	$ scripts/get_maintainer.pl -f drivers/perf/fsl_imx8_ddr_perf.c
> 	Frank Li <Frank.li@nxp.com> (maintainer:FREESCALE IMX DDR Performance Mo=
nitor DRIVER)
> 	Will Deacon <will.deacon@arm.com> (maintainer:ARM PMU PROFILING AND DEBU=
GGING)
> 	Mark Rutland <mark.rutland@arm.com> (maintainer:ARM PMU PROFILING AND DE=
BUGGING)
> 	Shawn Guo <shawnguo@kernel.org> (maintainer:ARM/FREESCALE IMX / MXC ARM =
ARCHITECTURE)
> 	Sascha Hauer <s.hauer@pengutronix.de> (maintainer:ARM/FREESCALE IMX / MX=
C ARM ARCHITECTURE)
> 	Pengutronix Kernel Team <kernel@pengutronix.de> (reviewer:ARM/FREESCALE =
IMX / MXC ARM ARCHITECTURE)
> 	Fabio Estevam <fabio.estevam@nxp.com> (reviewer:ARM/FREESCALE IMX / MXC =
ARM ARCHITECTURE)
> 	NXP Linux Team <linux-imx@nxp.com> (reviewer:ARM/FREESCALE IMX / MXC ARM=
 ARCHITECTURE)
> 	linux-arm-kernel@lists.infradead.org (open list:FREESCALE IMX DDR Perfor=
mance Monitor DRIVER)
> 	linux-kernel@vger.kernel.org (open list)
> =

> That's not necessarily a bad thing, but something I want people to make
> aware of.

For me, that's actually a good thing.  We, i.MX platform folks, get
copied on i.MX related driver changes in the right order - after driver
maintainers.

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
