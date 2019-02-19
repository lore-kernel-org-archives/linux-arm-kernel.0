Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44217C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:48:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 145CD2146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QowdcCDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145CD2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E2/ccinfWC0wv+mApaxwjtloK/4buk13+LRRsiqxvBA=; b=QowdcCDB0Hea08
	MukCM7jDFTN6nDTvEDZY+Li6EtdtMAmDG7Wal1DSmiDToynkIDUerrEgk3XUj5gDakAZBhenpXuDe
	18oZ3ezqPjOeecOjop9G1D4XKXUlpf59pCmvJhOgN/mq0miv+pj05cVJ2exlrlzCkrtMPU+30PmMB
	hmuRecY4EwHmlkxlvOUu9YUKuN0gJi36nLMYaMU5ZV59S4da3piMi4GzXymMRRFAvaJNyq5rg2cmC
	2VOGyW8FpqtVhhwfjNjymLU2zUK7tq8Vd2IqOoIRwsbpa2Kgr+o/h2OgItlzO7mndxZOOLkirlAW8
	9tg30GsQ/cBfqpNa8erw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw6h1-00039U-GJ; Tue, 19 Feb 2019 14:48:19 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw6gx-00035O-Iq
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 14:48:17 +0000
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <mfe@pengutronix.de>)
 id 1gw6gs-00037B-2h; Tue, 19 Feb 2019 15:48:10 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <mfe@pengutronix.de>)
 id 1gw6gq-0007nd-Lm; Tue, 19 Feb 2019 15:48:08 +0100
Date: Tue, 19 Feb 2019 15:48:08 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Anson Huang <anson.huang@nxp.com>
Subject: Re: [PATCH] dt-bindings: imx: update scu resource id headfile
Message-ID: <20190219144808.qqpaubjcsb4huoml@pengutronix.de>
References: <1550566601-11497-1-git-send-email-Anson.Huang@nxp.com>
 <20190219125211.2pg2bqxner4klcb5@pengutronix.de>
 <DB3PR0402MB3916AF3AA0283DB22DF61E2FF57C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB3916AF3AA0283DB22DF61E2FF57C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-IRC: #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 15:21:18 up 31 days, 19:03, 36 users,  load average: 0.07, 0.07, 0.03
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_064815_788873_7A482CC6 
X-CRM114-Status: GOOD (  17.35  )
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
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Anson,

On 19-02-19 13:21, Anson Huang wrote:
> Hi, Marco
> 
> Best Regards!
> Anson Huang
> 
> > -----Original Message-----
> > From: Marco Felsch [mailto:m.felsch@pengutronix.de]
> > 
> > Hi Anson,
> > 
> > On 19-02-19 09:01, Anson Huang wrote:
> > > Update i.MX SCU resource ID table according to latest system
> > > controller firmware.
> > 
> > will this happen every time the scu firmware gets a update?
> 
> If SCU firmware updates this table, then yes, it MUST keep same as SCU firmware,
> but such ID table is NOT updated very often, I checked the history in our internal tree, there
> are ONLY 3 updates since 2016.

Please don't get me wrong, but 3 times since 2016 == every year (since
now) == every 3rd kernel. This seems wrong to me. Can you explain me if
the following use-case will work:

Starting point:
 - firmware (incl. bootloader, dtb, scu and other nxp closed source fw)
   from 2017
 - kernel from 2017

Now the project update the kernel to a version from 2019, but the fw
won't be updated.

There are a lot of projects using such a approach to retrieve security
updates.

I don't like droping some ID's (e.g. IMX_SC_R_DC_0_CAPTURE0) by mark
them as unused or even worse give them a other meaning. IMHO the scu-api
should be stable since day 1 and the ID's should only be extended.
Marking ID's as deprecated is much better than moving them around.

Regards,
Marco

> 
> Anson.
> 
> > 
> > Regards,
> > Marco
> > 
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > >  include/dt-bindings/firmware/imx/rsrc.h | 39
> > > +++++++++++++++++++--------------
> > >  1 file changed, 22 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/include/dt-bindings/firmware/imx/rsrc.h
> > > b/include/dt-bindings/firmware/imx/rsrc.h
> > > index 4481f2d..ad747a8 100644
> > > --- a/include/dt-bindings/firmware/imx/rsrc.h
> > > +++ b/include/dt-bindings/firmware/imx/rsrc.h
> > > @@ -36,15 +36,15 @@
> > >  #define IMX_SC_R_DC_0_BLIT1		20
> > >  #define IMX_SC_R_DC_0_BLIT2		21
> > >  #define IMX_SC_R_DC_0_BLIT_OUT		22
> > > -#define IMX_SC_R_DC_0_CAPTURE0		23
> > > -#define IMX_SC_R_DC_0_CAPTURE1		24
> > > +#define IMX_SC_R_PERF			23
> > > +#define IMX_SC_R_UNUSED5		24
> > >  #define IMX_SC_R_DC_0_WARP		25
> > > -#define IMX_SC_R_DC_0_INTEGRAL0		26
> > > -#define IMX_SC_R_DC_0_INTEGRAL1		27
> > > +#define IMX_SC_R_UNUSED7		26
> > > +#define IMX_SC_R_UNUSED8		27
> > >  #define IMX_SC_R_DC_0_VIDEO0		28
> > >  #define IMX_SC_R_DC_0_VIDEO1		29
> > >  #define IMX_SC_R_DC_0_FRAC0		30
> > > -#define IMX_SC_R_DC_0_FRAC1		31
> > > +#define IMX_SC_R_UNUSED6		31
> > >  #define IMX_SC_R_DC_0			32
> > >  #define IMX_SC_R_GPU_2_PID0		33
> > >  #define IMX_SC_R_DC_0_PLL_0		34
> > > @@ -53,17 +53,17 @@
> > >  #define IMX_SC_R_DC_1_BLIT1		37
> > >  #define IMX_SC_R_DC_1_BLIT2		38
> > >  #define IMX_SC_R_DC_1_BLIT_OUT		39
> > > -#define IMX_SC_R_DC_1_CAPTURE0		40
> > > -#define IMX_SC_R_DC_1_CAPTURE1		41
> > > +#define IMX_SC_R_UNUSED9		40
> > > +#define IMX_SC_R_UNUSED10		41
> > >  #define IMX_SC_R_DC_1_WARP		42
> > > -#define IMX_SC_R_DC_1_INTEGRAL0		43
> > > -#define IMX_SC_R_DC_1_INTEGRAL1		44
> > > +#define IMX_SC_R_UNUSED11		43
> > > +#define IMX_SC_R_UNUSED12		44
> > >  #define IMX_SC_R_DC_1_VIDEO0		45
> > >  #define IMX_SC_R_DC_1_VIDEO1		46
> > >  #define IMX_SC_R_DC_1_FRAC0		47
> > > -#define IMX_SC_R_DC_1_FRAC1		48
> > > +#define IMX_SC_R_UNUSED13		48
> > >  #define IMX_SC_R_DC_1			49
> > > -#define IMX_SC_R_GPU_3_PID0		50
> > > +#define IMX_SC_R_UNUSED14		50
> > >  #define IMX_SC_R_DC_1_PLL_0		51
> > >  #define IMX_SC_R_DC_1_PLL_1		52
> > >  #define IMX_SC_R_SPI_0			53
> > > @@ -303,8 +303,8 @@
> > >  #define IMX_SC_R_M4_0_UART		287
> > >  #define IMX_SC_R_M4_0_I2C		288
> > >  #define IMX_SC_R_M4_0_INTMUX		289
> > > -#define IMX_SC_R_M4_0_SIM		290
> > > -#define IMX_SC_R_M4_0_WDOG		291
> > > +#define IMX_SC_R_UNUSED15		290
> > > +#define IMX_SC_R_UNUSED16		291
> > >  #define IMX_SC_R_M4_0_MU_0B		292
> > >  #define IMX_SC_R_M4_0_MU_0A0		293
> > >  #define IMX_SC_R_M4_0_MU_0A1		294
> > > @@ -323,8 +323,8 @@
> > >  #define IMX_SC_R_M4_1_UART		307
> > >  #define IMX_SC_R_M4_1_I2C		308
> > >  #define IMX_SC_R_M4_1_INTMUX		309
> > > -#define IMX_SC_R_M4_1_SIM		310
> > > -#define IMX_SC_R_M4_1_WDOG		311
> > > +#define IMX_SC_R_UNUSED17		310
> > > +#define IMX_SC_R_UNUSED18		311
> > >  #define IMX_SC_R_M4_1_MU_0B		312
> > >  #define IMX_SC_R_M4_1_MU_0A0		313
> > >  #define IMX_SC_R_M4_1_MU_0A1		314
> > > @@ -337,7 +337,7 @@
> > >  #define IMX_SC_R_IRQSTR_SCU2		321
> > >  #define IMX_SC_R_IRQSTR_DSP		322
> > >  #define IMX_SC_R_ELCDIF_PLL		323
> > > -#define IMX_SC_R_UNUSED6		324
> > > +#define IMX_SC_R_OCRAM			324
> > >  #define IMX_SC_R_AUDIO_PLL_0		325
> > >  #define IMX_SC_R_PI_0			326
> > >  #define IMX_SC_R_PI_0_PWM_0		327
> > > @@ -554,6 +554,11 @@
> > >  #define IMX_SC_R_VPU_MU_3		538
> > >  #define IMX_SC_R_VPU_ENC_1		539
> > >  #define IMX_SC_R_VPU			540
> > > -#define IMX_SC_R_LAST			541
> > > +#define IMX_SC_R_DMA_5_CH0		541
> > > +#define IMX_SC_R_DMA_5_CH1		542
> > > +#define IMX_SC_R_DMA_5_CH2		543
> > > +#define IMX_SC_R_DMA_5_CH3		544
> > > +#define IMX_SC_R_ATTESTATION		545
> > > +#define IMX_SC_R_LAST			546
> > >
> > >  #endif /* __DT_BINDINGS_RSCRC_IMX_H */
> > > --
> > > 2.7.4
> > >
> > >
> > >
> > 
> > --
> > Pengutronix e.K.                           |                             |
> > Industrial Linux Solutions                 |
> > https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fww
> > w.pengutronix.de%2F&amp;data=02%7C01%7Canson.huang%40nxp.com%7
> > Cfe709ac17a164d82c7d508d6966915fb%7C686ea1d3bc2b4c6fa92cd99c5c301
> > 635%7C0%7C0%7C636861775412076730&amp;sdata=05ZzPf2%2BQF10JXLLs
> > OPqDdqTi00BWXNHxmMOsQ1z0yI%3D&amp;reserved=0  |
> > Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
