Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72328C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:16:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 435232081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k46WS5Lw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 435232081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GXymQtSfZlFmsRk642QtFfRQ/B9WfOnpZ+OK/fBG1Ec=; b=k46WS5LwJyo6pu
	W1H7gRLg6poOs703m9AG2jeB4JJmtLyZIbpjPmB6UAvHq0vF389aqlHNfkqjqHC+YoI2k2I3PTB5p
	6kJoXZ058z3amMLciHaAKw83r8/2c0ARbPNvcFMMFJM4JREK6z/gdRrREIC08M95XEiaYV/KijLVc
	cA66p7j5Z7CO7V0No3cqc9IBxSWQa9jN8d1INjH1vT+g7YNCvxGQmMSUdLfvWdLVQigsXfYu6pllg
	W/DW7Erp7nDsHjTdyQ9iUGQd9xeFLHxLSCt4ucZtwqLjdOebVUD3b/UGPLEQQ6Ci3va07g8hcI/wK
	ANzzAgCI+CFSpL06BA3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUH6m-0006qZ-EI; Tue, 04 Dec 2018 20:15:52 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUH6i-0006pf-Fv
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 20:15:50 +0000
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gUH6U-0006Ex-Jf; Tue, 04 Dec 2018 21:15:34 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gUH6T-000581-Gh; Tue, 04 Dec 2018 21:15:33 +0100
Date: Tue, 4 Dec 2018 21:15:33 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / AVS: SmartReflex: Fix module licence specification
Message-ID: <20181204201533.u467nu3cgoktt7ef@pengutronix.de>
References: <20181008091818.1145-1-uwe@kleine-koenig.org>
 <CAJZ5v0jEHcPKchOmzd9AewGCT0zkXnRgL=QGZTW-xWcJ12HNoA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jEHcPKchOmzd9AewGCT0zkXnRgL=QGZTW-xWcJ12HNoA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_121548_687945_F82BED12 
X-CRM114-Status: GOOD (  16.87  )
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
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Rafael,

On Tue, Oct 09, 2018 at 09:56:52AM +0200, Rafael J. Wysocki wrote:
> On Mon, Oct 8, 2018 at 11:23 AM Uwe Kleine-K=F6nig <uwe@kleine-koenig.org=
> wrote:
> >
> > The header of this file claims "version 2" and not "or later". So adapt
> > the module licence specification accordingly.
> >
> > Signed-off-by: Uwe Kleine-K=F6nig <uwe@kleine-koenig.org>
> > ---
> >  drivers/power/avs/smartreflex.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartr=
eflex.c
> > index d29b6313cafc..9ed30b5d32c2 100644
> > --- a/drivers/power/avs/smartreflex.c
> > +++ b/drivers/power/avs/smartreflex.c
> > @@ -1062,6 +1062,6 @@ static void __exit sr_exit(void)
> >  module_exit(sr_exit);
> >
> >  MODULE_DESCRIPTION("OMAP Smartreflex Driver");
> > -MODULE_LICENSE("GPL");
> > +MODULE_LICENSE("GPL v2");
> >  MODULE_ALIAS("platform:" DRIVER_NAME);
> >  MODULE_AUTHOR("Texas Instruments Inc");
> > --
> =

> While you are at it, why don't you add a proper SPDX license ID to
> this file and drop the license bolierplate from the heading comment?

That would be a separate patch, right? And in contrast to this one
(which is a fix IMHO) it would only be an "improvement".

As this was just a drive-by change I won't follow up on this one. Take
it as is or don't.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
