Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1669C282F4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:21:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 993772084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CfZcbmV/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993772084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5sJNRzSYrmm/P70VS60JtusmvJFJi7vzk7FCa6FTzYk=; b=CfZcbmV/o5yg5f
	jTD4StCVM6UY8l1yJsEE2K+0+AEnZZKkLKBS6aiCLE1qmEIn7wN2XTMMoyi4hp0y7eV2jBv5OTiHi
	/zAyLtnYh4UigzCxZm5hJ+secU2RSsR8OBpNSGxlgECOjLaypt6GaOv08EWHHmQA+X1i0rZyHpN5+
	h3yCSa0lUCiC3NWw6eNAY6gKYjFywPt3RWdIion//dNFYkrh6lzJRYc5afpIzYMKVkgt3iEb0C3eJ
	cT1imJv8hvLXvdyGNhbTjemXDJpUlmxrBcpqPSEET8+mgOFuw5qvOStbcHMOqhXLF9vbCAuujqsAr
	sClvkMDBxnQr3u0QfiXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glUpV-0000pm-QR; Mon, 21 Jan 2019 08:21:13 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glUpR-0000om-P0; Mon, 21 Jan 2019 08:21:11 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 5F3E22078C; Mon, 21 Jan 2019 09:21:07 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr
 [90.88.156.87])
 by mail.bootlin.com (Postfix) with ESMTPSA id B9DF9206DC;
 Mon, 21 Jan 2019 09:21:06 +0100 (CET)
Date: Mon, 21 Jan 2019 09:21:06 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jianxin Pan <jianxin.pan@amlogic.com>
Subject: Re: [PATCH] MAINTAINERS: Add entry for Amlogic NAND controller driver
Message-ID: <20190121092106.2c97ebe2@xps13>
In-Reply-To: <3f098e44-9d9b-3d0a-3e19-5913077aeb07@amlogic.com>
References: <1547917355-13179-1-git-send-email-jianxin.pan@amlogic.com>
 <20190120160605.33689354@xps13>
 <3f098e44-9d9b-3d0a-3e19-5913077aeb07@amlogic.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_002109_942581_D93EEA28 
X-CRM114-Status: GOOD (  13.84  )
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
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 Hanjie Lin <hanjie.lin@amlogic.com>, Victor Wan <victor.wan@amlogic.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Richard Weinberger <richard@nod.at>, Neil Armstrong <narmstrong@baylibre.com>,
 linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@bootlin.com>,
 Jian Hu <jian.hu@amlogic.com>, Liang Yang <liang.yang@amlogic.com>,
 linux-mtd@lists.infradead.org, Kevin Hilman <khilman@baylibre.com>,
 Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgSmlhbnhpbiwKCkppYW54aW4gUGFuIDxqaWFueGluLnBhbkBhbWxvZ2ljLmNvbT4gd3JvdGUg
b24gTW9uLCAyMSBKYW4gMjAxOQoxMjoxODoxOCArMDgwMDoKCj4gSGkgTWlxdWVsLAo+IAo+IE9u
IDIwMTkvMS8yMCAyMzowNiwgTWlxdWVsIFJheW5hbCB3cm90ZToKPiA+IEhpIEppYW54aW4sCj4g
PiAKPiA+IEppYW54aW4gUGFuIDxqaWFueGluLnBhbkBhbWxvZ2ljLmNvbT4gd3JvdGUgb24gU3Vu
LCAyMCBKYW4gMjAxOQo+ID4gMDE6MDI6MzUgKzA4MDA6Cj4gPiAgIAo+ID4+IEFkZCBlbnRyeSBm
b3IgQW1sb2dpYyBOQU5EIGNvbnRyb2xsZXIgZHJpdmVyIGFuZCBpdHMgYmluZGluZ3NbMF0uCj4g
Pj4KPiA+PiBbMF0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8xNTQ3NTY2Njg0LTU3NDcy
LTEtZ2l0LXNlbmQtZW1haWwtamlhbnhpbi5wYW5AYW1sb2dpYy5jb20vCj4gPj4KPiA+PiBTaWdu
ZWQtb2ZmLWJ5OiBMaWFuZyBZYW5nIDxsaWFuZy55YW5nQGFtbG9naWMuY29tPgo+ID4+IFNpZ25l
ZC1vZmYtYnk6IEppYW54aW4gUGFuIDxqaWFueGluLnBhbkBhbWxvZ2ljLmNvbT4gIAo+ID4gCj4g
PiBJZiB5b3UgYXJlIHRoZSBhdXRob3Igb2YgdGhlIHBhdGNoIHlvdXIgU2lnbmVkLW9mZi1ieSBz
aG91bGQgY29tZSBmaXJzdC4gIAo+IE9LLgo+ID4gCj4gPiBBbHNvLCB3aHkgaXMgTGlhbmcgdGhl
IE1haW50YWluZXI/IFdoeSBub3QgeW91Pwo+ID4gICAKPiBZYW5nbGlhbmcgaXMgQW1sb2dpYyBt
YWludGFpbmVyIGZvciBOQU5EIGNvbnRyb2xsZXIuIEFuZCBhbGwgcGF0Y2hlcyBhYm91dCBhbWxv
Z2ljIE5BTkQgY29udHJvbGxlciBhcmUgZnJvbSBoaW0uCgpNYXliZSBidXQgaGUgbmV2ZXIgd3Jv
dGUgdG8gdGhlIE1MLCB0aGUgbWFpbnRhaW5lciBtYXkgYmUgc29tZW9uZSBlbHNlCnRoYW4gdGhl
IG9yaWdpbmFsIGF1dGhvciwgSSBqdXN0IHdhbnQgc29tZW9uZSB0byByZXZpZXcgcGF0Y2hlcyBh
bmQKaGVscCB0byBtYWludGFpbiB0aGUgZHJpdmVyLgoKWWFuZ2xpYW5nIGFyZSB5b3Ugd2lsbGlu
ZyB0byBkbyB0aGF0PwoKClRoYW5rcywKTWlxdcOobAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
