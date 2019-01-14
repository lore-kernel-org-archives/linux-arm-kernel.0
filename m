Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F06C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 07:15:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29DFF20659
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 07:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A/S+Uv4D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29DFF20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=milecki.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-ID:References:In-Reply-To:Subject:To:From:
	Date:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pJK7Sq4Wk0G9U5Oj4qNCWb+EsANPUIAiUesmEdW63VY=; b=A/S+Uv4DGSNNvN4D7PUgkDbDr
	kR4zbFLpbEuBK1EymJ8Vg72uoQYguCCP5VFYUh/nqco07mtgte2GpgWKH846h4N48u58NbsaHovxk
	ndmQfXvfAPamh/rPepqk4jxHek/UF0UvffWYmwNwUlBEk8Ryj2kYfocSIakSIgFki49IcI1TWIQob
	mHaK8uHF3WW/2dqhU69JZmtE/n7jG9ak+znaTTkS6i3+d2zsDNgpT9E2aJqLMSaCSKoheVtuwYQXT
	UAvl0AFKlivO+NQjermjoEnZbYHVZY4hpojxc1sSkr9N43YKhhWHPhJvrGZ9vTuoxQuqd5B7f1cuW
	AerVyauVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giwSy-0007ld-2k; Mon, 14 Jan 2019 07:15:24 +0000
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giwSt-0007l8-TO
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 07:15:21 +0000
Received: from player735.ha.ovh.net (unknown [10.109.143.225])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 21DC917A33E
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 08:15:13 +0100 (CET)
Received: from RCM-web7.webmail.mail.ovh.net
 (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
 (Authenticated sender: rafal@milecki.pl)
 by player735.ha.ovh.net (Postfix) with ESMTPSA id 7D8F51A0D9EE;
 Mon, 14 Jan 2019 07:15:05 +0000 (UTC)
MIME-Version: 1.0
Date: Mon, 14 Jan 2019 08:15:04 +0100
From: =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To: Dan Haab <riproute@gmail.com>
Subject: Re: [PATCH] ARM: dts: BCM53573: Relicense Luxul files to the GPL 2.0+
 / MIT
In-Reply-To: <1543795215-31863-1-git-send-email-dan.haab@luxul.com>
References: <1543795215-31863-1-git-send-email-dan.haab@luxul.com>
Message-ID: <1abbf738f6ac9808310e27a43f430cc9@milecki.pl>
X-Sender: rafal@milecki.pl
User-Agent: Roundcube Webmail/1.3.8
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
X-Ovh-Tracer-Id: 3962886197172538929
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrgedtgddutdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_231520_091256_BD9A8CE6 
X-CRM114-Status: UNSURE (   7.33  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Florian Fainelli <f.fainelli@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Dan Haab <dan.haab@luxul.com>, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMjAxOC0xMi0wMyAwMTowMCwgRGFuIEhhYWIgd3JvdGU6Cj4gVGhpcyBtYXRjaGVzIGxpY2Vu
c2luZyB1c2VkIGJ5IG90aGVyIEJDTTUzNTczIGZpbGVzIGFuZCBCQ001MzAxWC4KPiAKPiBTaWdu
ZWQtb2ZmLWJ5OiBEYW4gSGFhYiA8ZGFuLmhhYWJAbHV4dWwuY29tPgoKQWNrZWQtYnk6IFJhZmHF
giBNacWCZWNraSA8cmFmYWxAbWlsZWNraS5wbD4KCkZsb3JpYW46IHBpbmcgOikKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
