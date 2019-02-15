Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71750C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:08:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D4FF21900
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i0NNLM5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D4FF21900
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/5s0Kot8pf6/XqxXEqPZ/TcpQr8Axhtn+Gc0Fz3A4/Q=; b=i0NNLM5JLJeNwHbYvEZtpnQag
	sS4IrfjvGM1DnENvj48AvL9rYVBG1FsM9oSVquGY6ErVRUZzALhV817MOpY7tV7+El7JAZT91gQck
	mqwbAT6h9eLpgUb4y294oLdaTywK6KjDjcaHNWSWUSbBTO3irmQwzklgHhapj+BvzZ/AS2IfXyk8c
	VhMf9QQZOjmpljH9iLFZ7zov/Kjj6YLA4d9mRXWCeWnefQ7w5tps06/s0yBG5wxSIEfPIXobgl1BH
	DCquho5Szz4m3OQCqmyrgvgWgsirt5XGDBpdwAytWcLnIaUbJP2TbjnJ8DPhPL5dZX1XSdnsfDA8O
	on4dymLwA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gucIG-0006Nj-M5; Fri, 15 Feb 2019 12:08:36 +0000
Received: from relay1.mentorg.com ([192.94.38.131])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gucID-0006My-29; Fri, 15 Feb 2019 12:08:34 +0000
Received: from nat-ies.mentorg.com ([192.94.31.2]
 helo=SVR-IES-MBX-04.mgc.mentorg.com)
 by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
 id 1gucI4-0005MC-Ol from Akash_Gajjar@mentor.com ;
 Fri, 15 Feb 2019 04:08:24 -0800
Received: from [10.105.24.52] (137.202.0.90) by SVR-IES-MBX-04.mgc.mentorg.com
 (139.181.222.4) with Microsoft SMTP Server (TLS) id 15.0.1320.4;
 Fri, 15 Feb 2019 12:08:18 +0000
Subject: Re: [PATCH 2/4] arm64: dts: rockchip: rockpro64 dts remove unused node
To: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
References: <20190213170651.3210-1-Akash_Gajjar@mentor.com>
 <20190213170651.3210-3-Akash_Gajjar@mentor.com> <4653141.o6ZdamfZ6d@diego>
From: agajjar <Akash_Gajjar@mentor.com>
Message-ID: <ac22440d-3b64-1cf2-205c-52ea7c1c23f9@mentor.com>
Date: Fri, 15 Feb 2019 17:38:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <4653141.o6ZdamfZ6d@diego>
Content-Language: en-US
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-07.mgc.mentorg.com (139.181.222.7) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_040833_153331_57BD8C3A 
X-CRM114-Status: GOOD (  17.05  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Ck9uIDIvMTUvMjAxOSAyOjQ4IFBNLCBIZWlrbyBTdMO8Ym5lciB3cm90ZToKPiBBbSBNaXR0d29j
aCwgMTMuIEZlYnJ1YXIgMjAxOSwgMTg6MDY6MzggQ0VUIHNjaHJpZWIgQWthc2ggR2FqamFyOgo+
PiBsY2QgcGFuZWwgcGlubXV4IGFuZCB2Y2MxdjhfczMgcmVndWxhdG9yIGlzIHJlZHVuZGFudCBh
bmQgaGFzIGEgbm8gaW1wYWN0LAo+PiBzbyByZW1vdmluZyBpdC4KPj4KPj4gU2lnbmVkLW9mZi1i
eTogQWthc2ggR2FqamFyIDxBa2FzaF9HYWpqYXJAbWVudG9yLmNvbT4KSGkgSGVpa28sCj4gdmNj
MXY4X3MzIGlzIGFjdHVhbGx5IGFsc28gYSBlbW1jIHN1cHBseSwgc28gSSdkIGxpa2UgdG8ga2Vl
cCBpdCBhcm91bmQKPiBmb3IgY29tcGxldGVuZXMgc2FrZS4KCkVtbWMgbW9kdWxlIGlzIHN1cHBs
aWVkIGJ5IFBNSUMgdmNjM3YzX3MzIChTV0lUQ0hfUkVHMSkgYW5kIHZjY18xdjggCihEQ0RfUkVH
NCkuCgpTbyBJIGJlbGlldmUgcmVtb3ZpbmcgdmNjMXY4X3MzIGhhcyBubyBpbXBhY3Qgb24gZW1t
YyBzdXBwbHkgbGluZS4KCgpUaGFua3MsCkFrYXNoCgo+Cj4gSSd2ZSBub3cgZHJvcHBlZCB0aGUg
cmVndWxhdG9yIHBvcnRpb25zIHNvIHRoYXQgb25seSB0aGUgbGNkLXBpbm11eAo+IGdldHMgcmVt
b3ZlZCBhbmQgcmV3b3JkZWQgdGhlIGNvbW1pdCBtZXNzYWdlIGFjY29yZGluZ2x5Cj4gYW5kIGFw
cGxpZWQgdGhlIHJlc3VsdCBmb3IgNS4xCj4KPiBUaGFua3MKPiBIZWlrbwo+Cj4KPgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5l
bCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
