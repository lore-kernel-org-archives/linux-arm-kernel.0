Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA6FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:45:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2ECB21B18
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z3RrlAUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2ECB21B18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NbpRYr2QwdfNufXOZrlb5xTT9YD6iujIg0pz3bziPqc=; b=Z3RrlAUHj7pRMH
	oEdImxI/qSmoGA/HnBeFCy29YehBPZZtRwEVWxKdydYXq9g1pgXZf+fghzrsJVOYr8KNKwaU6R60f
	+l36fTZXLZoQfJQsMuvgg1eqfomAy3WX50l8TIylY0xsOqVTvuPAtbBc4+KyCppVhc2RuCkg18vxY
	WnVcLAuGRvhXcwNM2AFqiQiYkp41wH3TNSgO4PKlx2Pt1oo2QlwxvsqWy5kmpqCbjqLvyWoHksi7L
	0evXH6v2hUhIEqajieyJ5uK1yr0CnzrO3z48gWjKHtMjReyYUaM4Yh7b550SOWuHyRe+ugaXgtyKZ
	QPjZgaFIIn7s1bodP18A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gulI6-0007RQ-HR; Fri, 15 Feb 2019 21:45:02 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gulI2-0007Pv-2b
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 21:45:00 +0000
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gulHp-00075a-4b; Fri, 15 Feb 2019 22:44:45 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gulHo-0002hT-6k; Fri, 15 Feb 2019 22:44:44 +0100
Date: Fri, 15 Feb 2019 22:44:44 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Zhi Li <lznuaa@gmail.com>
Subject: Re: [PATCH V4 4/4] MAINTAINERS: Added imx DDR performonitor driver
 maintainer information
Message-ID: <20190215214444.n2watl6k5ij6ptfs@pengutronix.de>
References: <1550253761-26841-1-git-send-email-Frank.Li@nxp.com>
 <1550253761-26841-4-git-send-email-Frank.Li@nxp.com>
 <20190215200141.pncrzp3oaoja2mnd@pengutronix.de>
 <CAHrpEqTexakw-OXjUt3nTdroPxv2YVjT-8VmZTUpDeF6e_dZMw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHrpEqTexakw-OXjUt3nTdroPxv2YVjT-8VmZTUpDeF6e_dZMw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_134458_275733_3BCB444B 
X-CRM114-Status: GOOD (  15.16  )
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
 Aisheng Dong <aisheng.dong@nxp.com>, "festevam@gmail.com" <festevam@gmail.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Frank Li <frank.li@nxp.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 03:13:00PM -0600, Zhi Li wrote:
> On Fri, Feb 15, 2019 at 2:01 PM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > On Fri, Feb 15, 2019 at 06:03:16PM +0000, Frank Li wrote:
> > > Add DDR perf counter driver maintainer information
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > No change from v1 to v4
> > >
> > >  MAINTAINERS | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 6ba068e..687be0f 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -6163,6 +6163,13 @@ L:     linux-i2c@vger.kernel.org
> > >  S:   Maintained
> > >  F:   drivers/i2c/busses/i2c-cpm.c
> > >
> > > +FREESCALE IMX DDR Performance Monitor DRIVER
> > > +M:   Frank Li <Frank.li@nxp.com>
> > > +L:   linux-arm-kernel@lists.infradead.org
> > > +S:   Maintained
> > > +F:   drivers/perf/fsl_imx8_ddr_perf.c
> > > +F:   Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
> > > +
> >
> > With da8b7f0fb02b ("MAINTAINERS: add all files matching "imx" and "mxs"
> > to the IMX entry") that sits currently in next the "ARM/FREESCALE IMX /
> > MXC ARM ARCHITECTURE" also matches for these two files.
> >
> > Is this good here or not?
> =

> Yes! what's do you means?
> Needn't these entry because da8b7f0fb02b?

It's just that we then will have two entries that will match. In a tree
where I have both, this series and da8b7f0fb02b I see:

	$ scripts/get_maintainer.pl -f drivers/perf/fsl_imx8_ddr_perf.c
	Frank Li <Frank.li@nxp.com> (maintainer:FREESCALE IMX DDR Performance Moni=
tor DRIVER)
	Will Deacon <will.deacon@arm.com> (maintainer:ARM PMU PROFILING AND DEBUGG=
ING)
	Mark Rutland <mark.rutland@arm.com> (maintainer:ARM PMU PROFILING AND DEBU=
GGING)
	Shawn Guo <shawnguo@kernel.org> (maintainer:ARM/FREESCALE IMX / MXC ARM AR=
CHITECTURE)
	Sascha Hauer <s.hauer@pengutronix.de> (maintainer:ARM/FREESCALE IMX / MXC =
ARM ARCHITECTURE)
	Pengutronix Kernel Team <kernel@pengutronix.de> (reviewer:ARM/FREESCALE IM=
X / MXC ARM ARCHITECTURE)
	Fabio Estevam <fabio.estevam@nxp.com> (reviewer:ARM/FREESCALE IMX / MXC AR=
M ARCHITECTURE)
	NXP Linux Team <linux-imx@nxp.com> (reviewer:ARM/FREESCALE IMX / MXC ARM A=
RCHITECTURE)
	linux-arm-kernel@lists.infradead.org (open list:FREESCALE IMX DDR Performa=
nce Monitor DRIVER)
	linux-kernel@vger.kernel.org (open list)

That's not necessarily a bad thing, but something I want people to make
aware of.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
