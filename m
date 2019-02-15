Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02771C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:46:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2F6E222BE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MtTjzg80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F6E222BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EPm9RV6I/JVydZrPNJl0z5tfGUeU5tUcLkigdIhtYvs=; b=MtTjzg80u18B+B
	Pk/aRS5OHqrvs6VS/e2UonNCjMPUTxcreMM/pcmUFIrS2fnLcIpLPhpgKTv09bCZbIsTjOMNTuZ7J
	eILFd6ejElJTB7SGSFEwpNE6pIRnCaqUUBvb273OC0EoIuDst8VM51N3IQ9qCFJzvnyKnMx4aESHq
	keTw5AYhf+5sTV8MAtZeaZb8yrCEQMOqr1tGftcu0tTsU9ssAbEMUgacCM8Klb+e9TNbiAZKhn5n+
	VzH5C+G5vWHYD1vSNR8MR8shn6rO+ni/8PZJchI5HldqaIeOA7jBRadYQs8/zKpsBYqzleqhDVm18
	/oZMXLQmRxM44FEF8jNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gukNI-0007Ex-Jh; Fri, 15 Feb 2019 20:46:20 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gukNE-0007E1-C1; Fri, 15 Feb 2019 20:46:18 +0000
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32]
 helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gukN2-00032O-N0; Fri, 15 Feb 2019 21:46:04 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: agajjar <Akash_Gajjar@mentor.com>
Subject: Re: [PATCH 2/4] arm64: dts: rockchip: rockpro64 dts remove unused node
Date: Fri, 15 Feb 2019 21:46:03 +0100
Message-ID: <7155828.jr86DZMtXN@diego>
In-Reply-To: <ac22440d-3b64-1cf2-205c-52ea7c1c23f9@mentor.com>
References: <20190213170651.3210-1-Akash_Gajjar@mentor.com>
 <4653141.o6ZdamfZ6d@diego> <ac22440d-3b64-1cf2-205c-52ea7c1c23f9@mentor.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_124616_563436_0242DBDC 
X-CRM114-Status: GOOD (  12.63  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Shohei Maruyama <cheat.sc.linux@outlook.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Rob Herring <robh+dt@kernel.org>, Oskari Lemmela <oskari@lemmela.net>,
 Levin Du <djw@t-chip.com.cn>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Freitag, 15. Februar 2019, 13:08:16 CET schrieb agajjar:
> On 2/15/2019 2:48 PM, Heiko St=FCbner wrote:
> > Am Mittwoch, 13. Februar 2019, 18:06:38 CET schrieb Akash Gajjar:
> >> lcd panel pinmux and vcc1v8_s3 regulator is redundant and has a no
> >> impact,
> >> so removing it.
> >> =

> >> Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>
> =

> Hi Heiko,
> =

> > vcc1v8_s3 is actually also a emmc supply, so I'd like to keep it around
> > for completenes sake.
> =

> Emmc module is supplied by PMIC vcc3v3_s3 (SWITCH_REG1) and vcc_1v8
> (DCD_REG4).
> =

> So I believe removing vcc1v8_s3 has no impact on emmc supply line.

looking at the rockpro64 schematics page 10, I see vcca1v8_s3 linked
to the emmc_vdd_1v8 input and obviously also as reference for the saradc.

So I think we really could keep it around, so that the power-tree resembles
the schematics more.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
