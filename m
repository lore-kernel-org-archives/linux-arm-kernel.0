Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFB2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:02:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 064B820659
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PquiXfpk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064B820659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ocBKS6ZVx/Wx1S61sxspFfBWNbSONOb79oPR4p7koDk=; b=PquiXfpky455EO
	yOtt0374dAzpEcVx2Ez95D0BRCJhMDVgjmiXK5LkSumDUBKJF7iE8E3v/KdSBUcy7BEp1NgkXHvDh
	kBR4tjMjf1vCIcd+g1hejiC29YdJWn1jjGMQqNNJn4VrwV3b/Opdwg5G/Y4g3bXIGVO0FKQ/aiEtr
	gSMhr+eyPP89jrc16tgNVDc98Y/freTdBjvyYUFA82mCKsOfxb+LoWw0f2N7S6D2OjCX0AL2I7jlw
	KMDkG0PyJl9wZ8rMgXdnJIgd2paeavq5J0j9F1m//x1hyASDtUhA0cTsI6QSZjHow18bRcvmMLwIB
	btV4AtYSdho++iia3VwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj5d4-0007gT-L8; Mon, 14 Jan 2019 17:02:26 +0000
Received: from honk.sigxcpu.org ([24.134.29.49])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj5d1-0007fz-HO
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 17:02:25 +0000
Received: from localhost (localhost [127.0.0.1])
 by honk.sigxcpu.org (Postfix) with ESMTP id EA38CFB02;
 Mon, 14 Jan 2019 18:02:20 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
 by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JEz8QxCCztW0; Mon, 14 Jan 2019 18:02:19 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
 id 9349947303; Mon, 14 Jan 2019 18:02:18 +0100 (CET)
Date: Mon, 14 Jan 2019 18:02:18 +0100
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] arm64: dts: imx8mq: Add pwm
Message-ID: <20190114170218.GA4168@bogon.m.sigxcpu.org>
References: <20190114163034.GA24531@bogon.m.sigxcpu.org>
 <1547484331.2718.8.camel@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547484331.2718.8.camel@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_090223_733439_DC3786B4 
X-CRM114-Status: GOOD (  16.80  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,
On Mon, Jan 14, 2019 at 05:45:31PM +0100, Lucas Stach wrote:
> Hi Guido,
> =

> Am Montag, den 14.01.2019, 17:30 +0100 schrieb Guido G=FCnther:
> > We can reuse the pwm from fsl,imx27-pwm as with other imx SOCs.
> > =

> > > Signed-off-by: Guido G=FCnther <agx@sigxcpu.org>
> > ---
> > This is against linux-next (next-20190114)
> > =

> > =A0arch/arm64/boot/dts/freescale/imx8mq.dtsi | 44 +++++++++++++++++++++=
++
> > =A01 file changed, 44 insertions(+)
> > =

> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boo=
t/dts/freescale/imx8mq.dtsi
> > index 8e9d6d5ed7b2..53ed0bdfc06a 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > @@ -252,6 +252,50 @@
> > > =A0				clocks =3D <&clk IMX8MQ_CLK_WDOG3_ROOT>;
> > > =A0				status =3D "disabled";
> > > =A0			};
> > +
> > > > +			pwm1: pwm@30660000 {
> > > +				compatible =3D "fsl,imx8mq-pwm", "fsl,imx27-pwm";
> > > +				reg =3D <0x30660000 0x10000>;
> > > +				interrupts =3D <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
> > > +				clocks =3D <&clk IMX8MQ_CLK_PWM1_ROOT>,
> > +				<&clk IMX8MQ_CLK_PWM1_ROOT>;
> =

> Please align the second entry with the first one,as with all the other
> nodes in this file.

Emacs mode fighting with me. I'll send a v2 with that fixed and moved to
the AIPS2 bus.
Thanks,
 -- Guido

> =

> > +				clock-names =3D "ipg", "per";
> > > +				#pwm-cells =3D <2>;
> > > +				status =3D "disabled";
> > > +			};
> > +
> > > > +			pwm2: pwm@30670000 {
> > > +				compatible =3D "fsl,imx8mq-pwm", "fsl,imx27-pwm";
> > > +				reg =3D <0x30670000 0x10000>;
> > > +				interrupts =3D <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
> > > +				clocks =3D <&clk IMX8MQ_CLK_PWM2_ROOT>,
> > > +				<&clk IMX8MQ_CLK_PWM2_ROOT>;
> > > +				clock-names =3D "ipg", "per";
> > > +				#pwm-cells =3D <2>;
> > > +				status =3D "disabled";
> > > +			};
> > +
> > > > +			pwm3: pwm@30680000 {
> > > +				compatible =3D "fsl,imx8mq-pwm", "fsl,imx27-pwm";
> > > +				reg =3D <0x30680000 0x10000>;
> > > +				interrupts =3D <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> > > +				clocks =3D <&clk IMX8MQ_CLK_PWM3_ROOT>,
> > > +				<&clk IMX8MQ_CLK_PWM3_ROOT>;
> > > +				clock-names =3D "ipg", "per";
> > > +				#pwm-cells =3D <2>;
> > > +				status =3D "disabled";
> > > +			};
> > +
> > > > +			pwm4: pwm@30690000 {
> > > +				compatible =3D "fsl,imx8mq-pwm", "fsl,imx27-pwm";
> > > +				reg =3D <0x30690000 0x10000>;
> > > +				interrupts =3D <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> > > +				clocks =3D <&clk IMX8MQ_CLK_PWM4_ROOT>,
> > > +				<&clk IMX8MQ_CLK_PWM4_ROOT>;
> > > +				clock-names =3D "ipg", "per";
> > > +				#pwm-cells =3D <2>;
> > > +				status =3D "disabled";
> > +			};
> =

> All those addresses are within the AIPS2 bus range, so this patch adds
> them to the wrong bus.
> =

> Regards,
> Lucas
> =

> > =A0		};
> > =A0
> > > =A0		bus@30400000 { /* AIPS2 */
> =


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
