Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D89C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:50:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9065520838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gCnwO2WM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9065520838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2kQUANPMKhV0UN46W9ADRnHoe+Vv/hByBVLUY4jxQYI=; b=gCnwO2WM0exG92
	SQ+kvLP5d6JkxbZil25whRV310Cg/gkm6aSqa1RI7hGdU12QVF4pxlj5m0i2HOVj3PyHP6dsxCMvN
	+g+kJ6W4Q9JDKF5JTc23CtuQWVPyh11+f8c9V4F0vfGRUtFBQhzPZslZK35h/KudMZDDpcbOpnN2d
	MPawoFt1B0WQgT1Ltd1m9WcEYJVC7dZ3AQw8itOzvVN515FYxlH5YAJtZkqkwXkbIz0MmzsYoqa2q
	a+cDTsZk7XBqv+EpU823PTMYJtkCQ3Th6gDUKLXjLuqKQXb+pMJIKYAQNg1o6+ucAoxXZ8iTndRqO
	RVelrO1mf2pGOEoq6iGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt9AI-0005Na-AT; Mon, 11 Feb 2019 10:50:18 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt9AE-0005N9-0C
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 10:50:16 +0000
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gt9AA-0005Fn-5B; Mon, 11 Feb 2019 11:50:10 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gt9A9-000802-QN; Mon, 11 Feb 2019 11:50:09 +0100
Date: Mon, 11 Feb 2019 11:50:09 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] ARM: dts: Add devicetree for Eckelmann CI4x10
Message-ID: <20190211105009.ywskfljxx56un62e@pengutronix.de>
References: <20190205081825.rcoi2wx2bvxsyfjz@pengutronix.de>
 <20190208093306.14316-1-u.kleine-koenig@pengutronix.de>
 <CAOMZO5AODGe0MXme5+xN6y4cr6NqmM4Gz6=euZN=V7rL1At21g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOMZO5AODGe0MXme5+xN6y4cr6NqmM4Gz6=euZN=V7rL1At21g@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_025014_201977_F67F8BF3 
X-CRM114-Status: GOOD (  11.63  )
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
Cc: Gavin Schenk <g.schenk@eckelmann.de>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Fabio,

On Fri, Feb 08, 2019 at 08:48:02AM -0200, Fabio Estevam wrote:
> On Fri, Feb 8, 2019 at 7:33 AM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > +       pinctrl_usbh1: usbh1grp {
> > +               fsl,pins =3D <
> > +                       MX6QDL_PAD_EIM_D30__USB_H1_OC           0x80000=
000
> =

> No 0x80000000 please. Use the real IOMUX setting here so that we don't
> rely on the bootloader.
> =

> > +&pcie {
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&pinctrl_pcie>;
> > +       reset-gpio =3D <&gpio1 20 GPIO_ACTIVE_HIGH>;
> =

> I guess you meant GPIO_ACTIVE_LOW here instead?
> =

> The reset-gpio polarity is ignored by the imx6 PCI driver and assumed
> to be active low unless the "reset-gpio-active-high" is present.

I improved my tooling to catch these two problems. I found quite some
offenders, will send fixes after lunch.

Thanks for catching these.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
