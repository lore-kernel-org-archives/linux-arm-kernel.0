Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6C5C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:25:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 464E821B1C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rR7V4vUn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 464E821B1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iG5YqLazQyX5Pioawt2qG49qroPlnveB6jHhQ0MQgUg=; b=rR7V4vUnAPuntw
	HBu5FJFPJ8Elf/TvXBWhgwczWl1wGT2EgTiHoxNpwzBt6eVC62a9W73rMBpNfCL6fySJwhaaCW1c/
	uHyGuKRB4kDyftBduiYs6gimanAF4eRWesJaETxzl8KP/+lrbf93es1/V6gIIv/kNEVMZlsHccWup
	+hEB3hgmofFshZzu9Q+TprBRlW/W5IdaKryzfMJOTnoq//gZ7dk06KYXxjrGWI8OqPoSxwuKWj/VP
	r7Rqwp9gaVk7+T2SpXn6AsEzOdOjKqNX7ZTLvCtpdM97ujPKfT5gyFicj/xQ7DpjmFhEyedCE07XV
	UXP5EVXcPxZWpfayS9oA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guZkL-0005l8-U4; Fri, 15 Feb 2019 09:25:25 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guZkI-0005hp-8s; Fri, 15 Feb 2019 09:25:23 +0000
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32]
 helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1guZjo-0000Ec-VQ; Fri, 15 Feb 2019 10:24:52 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Akash Gajjar <Akash_Gajjar@mentor.com>
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: rockpro64 dts add usb regulator
Date: Fri, 15 Feb 2019 10:24:52 +0100
Message-ID: <46988202.fxV2O2ZroW@diego>
In-Reply-To: <20190213170651.3210-5-Akash_Gajjar@mentor.com>
References: <20190213170651.3210-1-Akash_Gajjar@mentor.com>
 <20190213170651.3210-5-Akash_Gajjar@mentor.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_012522_559211_A5FE732E 
X-CRM114-Status: UNSURE (   9.40  )
X-CRM114-Notice: Please train this message.
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
 Rob Herring <robh+dt@kernel.org>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Oskari Lemmela <oskari@lemmela.net>, Levin Du <djw@t-chip.com.cn>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Mittwoch, 13. Februar 2019, 18:06:40 CET schrieb Akash Gajjar:
> vcc5v0_host and vcc5v0_typec is supplied by vcc5v0_usb and not vcc5v0_sys.
> add node for vcc5v0_usb fixed regulator.
> 
> Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>

applied for (hopefully) 5.1

Thanks
Heiko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
