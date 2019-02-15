Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8528C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:53:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8013218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JuW6ANVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8013218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vSg11RiUTa25CkGsd+woWsoDuxlGrFUs6JZJAXPPq1I=; b=JuW6ANVilOjIui
	dHAnO4/DGzSIEA5r1FJ+qn/DOnTQXKVAPHemEXmTf4WO5KbM/5ClEnsCJUkmM2NAIJwD0rPRw4Qq5
	6z+uRiCSaj0CACjgxfNLf9cMKHqGSg8hUvrqs7BGhcYAuaYCRgtGs32yunxSlhMdAj3bz63ivoPpS
	xeTkd1y0bBxF7NuZkUnzVHrtVxYE7vraR/eFYyQnqXISQDum0s0GBXmboeHpp8IchibiI4yEXOdh0
	AOfit50cKcp3p6HPzLRFHQAh/EDQiKesJ03aMVfBks6VsilDWJ1f776Re4D9Sl7zXeos9l9UNl3U2
	Z+7Ic5C38ewZqaaUozGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gudvX-0005vC-Tn; Fri, 15 Feb 2019 13:53:15 +0000
Received: from relay12.mail.gandi.net ([217.70.178.232])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gudvU-0005uK-35
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 13:53:14 +0000
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr
 [90.88.30.68]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay12.mail.gandi.net (Postfix) with ESMTPSA id 9339B200008;
 Fri, 15 Feb 2019 13:53:01 +0000 (UTC)
Date: Fri, 15 Feb 2019 14:53:00 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Frank Lee <tiny.windzz@gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: allwinner: h6: Add CPU Operating
 Performance Points table
Message-ID: <20190215135300.vlbtxi6viinakeeg@flea>
References: <20190214130910.9201-1-tiny.windzz@gmail.com>
 <20190214130910.9201-5-tiny.windzz@gmail.com>
 <20190214143842.nqsh6trwdjxq2ecd@flea>
 <CAEExFWuxrVC1J0g93R3ifaDxOGy-20B4jftoHw932V7+wqhtxw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEExFWuxrVC1J0g93R3ifaDxOGy-20B4jftoHw932V7+wqhtxw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_055312_420134_58AC6038 
X-CRM114-Status: GOOD (  19.00  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, robh+dt@kernel.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 10:52:16PM +0800, Frank Lee wrote:
> On Thu, Feb 14, 2019 at 10:38 PM Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> >
> > Hi,
> >
> > On Thu, Feb 14, 2019 at 08:09:10AM -0500, Yangtao Li wrote:
> > > Add an OPP (Operating Performance Points) table for the CPU cores to
> > > enable DVFS (Dynamic Voltage & Frequency Scaling) on the H6. This
> > > information comes from github.
> > >
> > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > ---
> > >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 61 ++++++++++++++++++++
> > >  1 file changed, 61 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > index 57a1390ecdc2..46a4a69eb38f 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > @@ -28,6 +28,8 @@
> > >                       enable-method = "psci";
> > >                       clocks = <&ccu CLK_CPUX>;
> > >                       clock-latency-ns = <244144>; /* 8 32k periods */
> > > +                     operating-points-v2 = <&cpu_opp_table>;
> > > +                     #cooling-cells = <2>;
> > >               };
> > >
> > >               cpu1: cpu@1 {
> > > @@ -37,6 +39,8 @@
> > >                       enable-method = "psci";
> > >                       clocks = <&ccu CLK_CPUX>;
> > >                       clock-latency-ns = <244144>; /* 8 32k periods */
> > > +                     operating-points-v2 = <&cpu_opp_table>;
> > > +                     #cooling-cells = <2>;
> > >               };
> > >
> > >               cpu2: cpu@2 {
> > > @@ -46,6 +50,8 @@
> > >                       enable-method = "psci";
> > >                       clocks = <&ccu CLK_CPUX>;
> > >                       clock-latency-ns = <244144>; /* 8 32k periods */
> > > +                     operating-points-v2 = <&cpu_opp_table>;
> > > +                     #cooling-cells = <2>;
> > >               };
> > >
> > >               cpu3: cpu@3 {
> > > @@ -55,6 +61,61 @@
> > >                       enable-method = "psci";
> > >                       clocks = <&ccu CLK_CPUX>;
> > >                       clock-latency-ns = <244144>; /* 8 32k periods */
> > > +                     operating-points-v2 = <&cpu_opp_table>;
> > > +                     #cooling-cells = <2>;
> > > +             };
> > > +     };
> > > +
> > > +     cpu_opp_table: opp_table {
> > > +             compatible = "operating-points-v2";
> > > +             opp-shared;
> > > +
> > > +             opp@480000000 {
> > > +                     opp-hz = /bits/ 64 <480000000>;
> > > +                     opp-microvolt = <800000 800000 880000>;
> > > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > > +             };
> > > +
> > > +             opp@720000000 {
> > > +                     opp-hz = /bits/ 64 <720000000>;
> > > +                     opp-microvolt = <800000 800000 880000>;
> > > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > > +             };
> > > +
> > > +             opp@816000000 {
> > > +                     opp-hz = /bits/ 64 <816000000>;
> > > +                     opp-microvolt = <800000 800000 880000>;
> > > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > > +             };
> > > +
> > > +             opp@888000000 {
> > > +                     opp-hz = /bits/ 64 <888000000>;
> > > +                     opp-microvolt = <800000 800000 940000>;
> > > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > > +             };
> > > +
> > > +             opp@1080000000 {
> > > +                     opp-hz = /bits/ 64 <1080000000>;
> > > +                     opp-microvolt = <840000 840000 1060000>;
> > > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > > +             };
> > > +
> > > +             opp@1320000000 {
> > > +                     opp-hz = /bits/ 64 <1320000000>;
> > > +                     opp-microvolt = <900000 900000 1160000>;
> > > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > > +             };
> > > +
> > > +             opp@1488000000 {
> > > +                     opp-hz = /bits/ 64 <1488000000>;
> > > +                     opp-microvolt = <960000 960000 1160000>;
> > > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> > > +             };
> > > +
> > > +             opp@1800000000 {
> > > +                     opp-hz = /bits/ 64 <1800000000>;
> > > +                     opp-microvolt = <1060000 1060000 1160000>;
> > > +                     clock-latency-ns = <244144>; /* 8 32k periods */
> >
> > So we definitely want to have that tested, especially since cpufreq
> > can lead to all kind of hard to debug errors (brown-outs, CPU lockups,
> > cache corruption, etc.). I good way to test that would be to use
> > cpufreq-ljt-stress-test here:
> > https://github.com/ssvb/cpuburn-arm/blob/master/cpufreq-ljt-stress-test
> >
> > I'm especially worried about the higher frequencies that will probably
> > make the SoC heat too much
>
> Indeed, in order to avoid this situation, it is best to have cpu cooling
> support(But now it does not support thermal driver? ).
> 
> In this case, perhaps we should remove the frequency beyond a certain
> range to avoid the CPU being too hot?

Yeah, that seems like a nice solution until we have the thermal sensor
running.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
