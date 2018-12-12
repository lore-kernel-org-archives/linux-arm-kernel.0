Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124A3C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:02:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5EFC2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cFyfDySN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5EFC2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yxGLI/csXwE6/3xbY/fAmmgmrvhgiDt/qRibqvNQKEY=; b=cFyfDySN6m0pJR
	zgNIBPZluNbdbxaX0oIsLNCGKI7s67gGo1fCj9Pmux/ptrlOyF5OijvBdFJUM0gxaNM/sKPU1K1bj
	STgknoA0IhtHpSuaipEkt2kdi30ByWADZUlsHHaRvhg12gokBsE/tnNCW/Kl6UD+bks5p7L1rVOLt
	39syJYFZ/D88v99CdDJXoFKvTLapWv1L9RT1AgIIn4bgFDRCh7NciE2ULeSqpNpe/W6RQg/B09rE5
	Nm3+cpe0FzcKlOlHDUi7C98E/ertZm7J6rqt+RXOqTpLXMcQULFkyjm7oiphOII0wkO9HeXWwrYj/
	xU4RHNnnjP5nBM2qkoxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX0Pa-0005n4-JF; Wed, 12 Dec 2018 09:02:34 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX0PX-0005lZ-Ol
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 09:02:33 +0000
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gX0PG-0003QB-1g; Wed, 12 Dec 2018 10:02:14 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gX0PF-0001tT-Al; Wed, 12 Dec 2018 10:02:13 +0100
Date: Wed, 12 Dec 2018 10:02:13 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: add all files matching "imx" and "mxs" to
 the IMX entry
Message-ID: <20181212090213.muqk53yr73h7qcup@pengutronix.de>
References: <20181122075742.31966-1-u.kleine-koenig@pengutronix.de>
 <20181122081704.pk6oqw664ewpkenm@pengutronix.de>
 <20181122083558.utya62w3hlcyukdw@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181122083558.utya62w3hlcyukdw@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_010231_957570_08B47534 
X-CRM114-Status: GOOD (  19.64  )
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>,
 kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>,
 Robin Gong <yibin.gong@nxp.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Shawn,

On Thu, Nov 22, 2018 at 09:35:58AM +0100, Uwe Kleine-K=F6nig wrote:
> On Thu, Nov 22, 2018 at 09:17:04AM +0100, Robert Schwebel wrote:
> > On Thu, Nov 22, 2018 at 08:57:42AM +0100, Uwe Kleine-K=F6nig wrote:
> > > This way also the spi, i2c and other drivers are covered.
> > > =

> > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > > Hello,
> > > =

> > > I was surprised by changes to the spi-imx driver[1]. To lessen the
> > > chances that this happens again, I like making the IMX entry match all
> > > relevant drivers.
> > > =

> > > Best regards
> > > Uwe
> > > =

> > > [1] FTR: I didn't test yet, but I think
> > > 987a2dfe3f0485a82d87106e7e1c43f35c1d3b09 broke i.MX31 and i.MX35. Even
> > > though a later patch made spi_imx_dma_transfer fail if .setup_wml isn=
't
> > > provided, I guess this only changes from a NULL pointer exception to a
> > > non-functional driver.
> > > =

> > >  MAINTAINERS | 11 ++---------
> > >  1 file changed, 2 insertions(+), 9 deletions(-)
> > > =

> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index b755a89fa325..cb9cbaa1ba19 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -1517,15 +1517,8 @@ R:	NXP Linux Team <linux-imx@nxp.com>
> > >  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribe=
rs)
> > >  S:	Maintained
> > >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.=
git
> > > -F:	arch/arm/mach-imx/
> > > -F:	arch/arm/mach-mxs/
> > > -F:	arch/arm/boot/dts/imx*
> > > -F:	arch/arm/configs/imx*_defconfig
> > > -F:	drivers/clk/imx/
> > > -F:	drivers/firmware/imx/
> > > -F:	drivers/soc/imx/
> > > -F:	include/linux/firmware/imx/
> > > -F:	include/soc/imx/
> > > +N:	imx
> > > +N:	mxs
> > =

> > This probably also matches drivers/media/i2c/*imx*, no?
> =

> Right, I didn't identify these as Sony stuff. Maybe NXP could sue them
> to rename their products? :-)
> =

> So we need instead of
> =

> 	N: imx
> =

> better:
> =

> 	N: (?<!drivers/media/i2c/)imx
> =

> Or we add X: drivers/media/i2c/ ?

I didn't receive any feedback from you. Are you positive in general to
let the IMX entry match all relevant drivers? If yes, I'd respin this
patch, probably using the more conservative "X: drivers/media/i2c"
approach in stead of the negative look-behind trick.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
