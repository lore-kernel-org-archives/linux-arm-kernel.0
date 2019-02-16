Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B10C10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 15:21:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9FC9222A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 15:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BhZdzoqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9FC9222A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=93t0SrkDdscvaw+VKAcieV824nSt2mUJohB1CIhhwNk=; b=BhZdzoqKSqsqvxm+yw7K2oOg6
	TX1HmoupEYBp2NJsosQVltn9iU72kXf26/c/1s8M3VuUTd3lDCCAodx+j7cO3s5IKVOw3yQze5XKu
	G1y5L/ecXr3EHAG8iLpX3J29ulYWCaklheWxz0o/n53JMwAr/dE3jiUAwoFCjqwicSz4m4EZUrkhu
	LlM/ay5ZhHtI59HasyFdR69DQsMvPm9YDavyjhuUgHn7qHMh5VgwLP2ines9C/2FGlPKx6eNpS4QS
	FC4lu3MUOt+StesuQ2sWm+Cbc5FwwiBZv3MlvlmZx3LLvjGxM9kZ+iVQfOAX5oTjMFMY0PUP1eIDX
	ixMKawhiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gv1mU-0005X0-T4; Sat, 16 Feb 2019 15:21:30 +0000
Received: from relay1.mentorg.com ([192.94.38.131])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gv1mQ-0005Va-FF; Sat, 16 Feb 2019 15:21:28 +0000
Received: from nat-ies.mentorg.com ([192.94.31.2]
 helo=SVR-IES-MBX-04.mgc.mentorg.com)
 by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
 id 1gv1m4-0000Lj-IJ from Akash_Gajjar@mentor.com ;
 Sat, 16 Feb 2019 07:21:04 -0800
Received: from [172.30.152.20] (137.202.0.90) by
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Sat, 16 Feb 2019 15:20:57 +0000
Subject: Re: [PATCH 2/4] arm64: dts: rockchip: rockpro64 dts remove unused node
To: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
References: <20190213170651.3210-1-Akash_Gajjar@mentor.com>
 <4653141.o6ZdamfZ6d@diego> <ac22440d-3b64-1cf2-205c-52ea7c1c23f9@mentor.com>
 <7155828.jr86DZMtXN@diego>
From: agajjar <Akash_Gajjar@mentor.com>
Message-ID: <468cbdb5-954a-bb1b-106f-14e387f6781f@mentor.com>
Date: Sat, 16 Feb 2019 20:50:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <7155828.jr86DZMtXN@diego>
Content-Language: en-US
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-05.mgc.mentorg.com (139.181.222.5) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190216_072126_503781_AE652A17 
X-CRM114-Status: GOOD (  15.66  )
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

T24gMi8xNi8yMDE5IDI6MTYgQU0sIEhlaWtvIFN0w7xibmVyIHdyb3RlOgo+IEFtIEZyZWl0YWcs
IDE1LiBGZWJydWFyIDIwMTksIDEzOjA4OjE2IENFVCBzY2hyaWViIGFnYWpqYXI6Cj4+IE9uIDIv
MTUvMjAxOSAyOjQ4IFBNLCBIZWlrbyBTdMO8Ym5lciB3cm90ZToKPj4+IEFtIE1pdHR3b2NoLCAx
My4gRmVicnVhciAyMDE5LCAxODowNjozOCBDRVQgc2NocmllYiBBa2FzaCBHYWpqYXI6Cj4+Pj4g
bGNkIHBhbmVsIHBpbm11eCBhbmQgdmNjMXY4X3MzIHJlZ3VsYXRvciBpcyByZWR1bmRhbnQgYW5k
IGhhcyBhIG5vCj4+Pj4gaW1wYWN0LAo+Pj4+IHNvIHJlbW92aW5nIGl0Lgo+Pj4+Cj4+Pj4gU2ln
bmVkLW9mZi1ieTogQWthc2ggR2FqamFyIDxBa2FzaF9HYWpqYXJAbWVudG9yLmNvbT4KPj4gSGkg
SGVpa28sCj4+Cj4+PiB2Y2MxdjhfczMgaXMgYWN0dWFsbHkgYWxzbyBhIGVtbWMgc3VwcGx5LCBz
byBJJ2QgbGlrZSB0byBrZWVwIGl0IGFyb3VuZAo+Pj4gZm9yIGNvbXBsZXRlbmVzIHNha2UuCj4+
IEVtbWMgbW9kdWxlIGlzIHN1cHBsaWVkIGJ5IFBNSUMgdmNjM3YzX3MzIChTV0lUQ0hfUkVHMSkg
YW5kIHZjY18xdjgKPj4gKERDRF9SRUc0KS4KPj4KPj4gU28gSSBiZWxpZXZlIHJlbW92aW5nIHZj
YzF2OF9zMyBoYXMgbm8gaW1wYWN0IG9uIGVtbWMgc3VwcGx5IGxpbmUuCj4gbG9va2luZyBhdCB0
aGUgcm9ja3BybzY0IHNjaGVtYXRpY3MgcGFnZSAxMCwgSSBzZWUgdmNjYTF2OF9zMyBsaW5rZWQK
PiB0byB0aGUgZW1tY192ZGRfMXY4IGlucHV0IGFuZCBvYnZpb3VzbHkgYWxzbyBhcyByZWZlcmVu
Y2UgZm9yIHRoZSBzYXJhZGMuCgpZb3UgYXJlIHJlZmVycmluZyBQaWxvdCBwcm9kdWN0aW9uIHJl
bGVhc2UgKHJvY2twcm82NF92MjAtU0NILnBkZiksIApwbGVhc2UgcmVmZXIgU2Vjb25kIGJhdGNo
IHByb2R1Y3Rpb24gcmVsZWFzZSAocm9ja3BybzY0X3YyMS1TQ0gucGRmKS4KCmJvdGggdGhlIHNj
aGVtYXRpYyByZWxlYXNlIGlzIGF2YWlsYWJsZSBhdCAKaHR0cDovL3dpa2kucGluZTY0Lm9yZy9p
bmRleC5waHAvUk9DS1BybzY0X01haW5fUGFnZQoKPgo+IFNvIEkgdGhpbmsgd2UgcmVhbGx5IGNv
dWxkIGtlZXAgaXQgYXJvdW5kLCBzbyB0aGF0IHRoZSBwb3dlci10cmVlIHJlc2VtYmxlcwo+IHRo
ZSBzY2hlbWF0aWNzIG1vcmUuCgpUaGFua3MsCgpBa2FzaAoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0
CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
