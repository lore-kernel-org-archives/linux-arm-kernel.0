Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A7EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:01:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C066A222D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eNUUr2Pv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C066A222D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I4BsbKCiyBPHtXkIHgjbOYO1mm1raxsfTYDdARnqd9A=; b=eNUUr2PvcgTFPu
	PmbYhREvKEztQabfcjbCinN/oWAQ0SSvuQEpJ89qZhOMphGFS/90nyrd5maB+sP8Y45vvHn0Sz3AH
	hfCrUaQqRpRSvAHy8ezqxIvtV2vGFBRvgPHsJBin2Rvt7nTfbI1hNR/gX28lCA7NomF4rWrNgrf3z
	pigbvLDejP46/pOJgGVtn5eRFxqDl3ZbsnEXPbkFR2+2UIsJdXFI5cI2mpvNztfR/K9g8RSAwUmcS
	i7ZOeorw8G38RMvGvfz6dCE6HfCMm84QWHkPpxoOFOHKBQx7C7WtHLQBe0jIHeEB/xtFXd/ng05SP
	fFY0YT/UfCUHlBiVfykw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gujgK-0001kE-0N; Fri, 15 Feb 2019 20:01:56 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gujgG-0001jJ-Od
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 20:01:54 +0000
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gujg6-0006Vt-NS; Fri, 15 Feb 2019 21:01:42 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gujg5-0008Lm-If; Fri, 15 Feb 2019 21:01:41 +0100
Date: Fri, 15 Feb 2019 21:01:41 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Frank Li <frank.li@nxp.com>
Subject: Re: [PATCH V4 4/4] MAINTAINERS: Added imx DDR performonitor driver
 maintainer information
Message-ID: <20190215200141.pncrzp3oaoja2mnd@pengutronix.de>
References: <1550253761-26841-1-git-send-email-Frank.Li@nxp.com>
 <1550253761-26841-4-git-send-email-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550253761-26841-4-git-send-email-Frank.Li@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_120152_958071_D1824B5C 
X-CRM114-Status: GOOD (  11.91  )
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
 "festevam@gmail.com" <festevam@gmail.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "lznuaa@gmail.com" <lznuaa@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 06:03:16PM +0000, Frank Li wrote:
> Add DDR perf counter driver maintainer information
> =

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> No change from v1 to v4
> =

>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> =

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6ba068e..687be0f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6163,6 +6163,13 @@ L:	linux-i2c@vger.kernel.org
>  S:	Maintained
>  F:	drivers/i2c/busses/i2c-cpm.c
>  =

> +FREESCALE IMX DDR Performance Monitor DRIVER
> +M:	Frank Li <Frank.li@nxp.com>
> +L:	linux-arm-kernel@lists.infradead.org
> +S:	Maintained
> +F:	drivers/perf/fsl_imx8_ddr_perf.c
> +F:	Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
> +

With da8b7f0fb02b ("MAINTAINERS: add all files matching "imx" and "mxs"
to the IMX entry") that sits currently in next the "ARM/FREESCALE IMX /
MXC ARM ARCHITECTURE" also matches for these two files.

Is this good here or not?

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
