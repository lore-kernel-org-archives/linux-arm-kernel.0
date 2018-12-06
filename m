Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865F2C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:03:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BECA20878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ITh5yZxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BECA20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:
	In-reply-to:Subject:To:From:References:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ja6lmRSCMl3BcliF1OGeQbyxJmXJaaOhEAeM4Asw+4M=; b=ITh5yZxhIfI7CuzZh0gvOj5C5r
	QDg7tTWi1e6J7thah6PslXTTySYP++k914Mpht300PnthTCbEg2o0XNAWIRddnq8oHk0B2FVFAmqB
	ofayJZ42cS/V2JgIDaStZNvMV8bVvYMe6my04Ybs0n7C/Vlz6u4uwXQLIQ19/Q/GdGe0J9o6vtNw+
	uOK0uGlSCKgp6ljLUiDPLB8HO8wiVF5bK5ns9ev5pzHoRSouGP4SNv8zOLpl/59WIwUkQ2OwfJ31K
	xonJTek/7T/EG/4EL+tO86h2QqBnBJSjZSEYrznETcPyhMpiLJ0VTVgl4/GZJluj64tEB6+HhxMRn
	MTw84jCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUx3W-0001mN-JO; Thu, 06 Dec 2018 17:03:18 +0000
Received: from guitar.tcltek.co.il ([192.115.133.116] helo=mx.tkos.co.il)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUx3R-0001kc-Gu
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 17:03:17 +0000
Received: from tarshish (unknown [10.0.8.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx.tkos.co.il (Postfix) with ESMTPS id 3339244011A;
 Thu,  6 Dec 2018 19:02:58 +0200 (IST)
References: <634478cc2f11ea3ee3b89393ae6d82f39d3c8531.1544095149.git.baruch@tkos.co.il>
 <87tvjqveee.fsf@bootlin.com>
User-agent: mu4e 1.0; emacs 25.2.2
From: Baruch Siach <baruch@tkos.co.il>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH] arm64: dts: clearfog-gt-8k: describe mini-PCIe CON2 USB
In-reply-to: <87tvjqveee.fsf@bootlin.com>
Date: Thu, 06 Dec 2018 19:02:57 +0200
Message-ID: <87ftvak2pq.fsf@tkos.co.il>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_090313_780018_9E9B0721 
X-CRM114-Status: GOOD (  10.54  )
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
Cc: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgR3JlZ29yeSwKCkdyZWdvcnkgQ0xFTUVOVCB3cml0ZXM6Cj4gIE9uIGpldS4sIGTDqWMuIDA2
IDIwMTgsIEJhcnVjaCBTaWFjaCA8YmFydWNoQHRrb3MuY28uaWw+IHdyb3RlOgo+Cj4+IEVuYWJs
ZSB0aGUgVVNCMyBwZXJpcGhlcmFsIHRoYXQgaXMgd2lyZWQgdG8gQ09OMiBvbiB0aGUgQ2xlYXJm
b2cgR1QtOEsKPj4gYm9hcmQuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEJhcnVjaCBTaWFjaCA8YmFy
dWNoQHRrb3MuY28uaWw+Cj4+IC0tLQo+PiAgYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2Fy
bWFkYS04MDQwLWNsZWFyZm9nLWd0LThrLmR0cyB8IDQgKysrKwo+PiAgMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9t
YXJ2ZWxsL2FybWFkYS04MDQwLWNsZWFyZm9nLWd0LThrLmR0cyBiL2FyY2gvYXJtNjQvYm9vdC9k
dHMvbWFydmVsbC9hcm1hZGEtODA0MC1jbGVhcmZvZy1ndC04ay5kdHMKPj4gaW5kZXggZGZiMjY2
NjFhODhlLi41YjRhOTYwOWUzMWYgMTAwNjQ0Cj4+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
bWFydmVsbC9hcm1hZGEtODA0MC1jbGVhcmZvZy1ndC04ay5kdHMKPj4gKysrIGIvYXJjaC9hcm02
NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS04MDQwLWNsZWFyZm9nLWd0LThrLmR0cwo+PiBAQCAt
MjgyLDYgKzI4MiwxMCBAQAo+PiAgCXZxbW1jLXN1cHBseSA9IDwmdl8zXzM+Owo+PiAgfTsKPj4K
Pj4gKyZjcDBfdXNiM18xIHsKPgo+IERvbid0IHlvdSBoYXZlIGFueSBwaHkgZm9yIHRoaXMgVVNC
MyBwb3J0PwoKTm90IGFzIGZhciBhcyBJIGNhbiBzZWUuIFdoeSB3b3VsZCBJIG5lZWQgb25lPyBU
aGUgc2VyZGVzIHNpZ25hbHMgYXJlCmNvbm5lY3RlZCBkaXJlY3RseSB0byB0aGUgbWluaS1QQ0ll
LCBqdXN0IGxpa2UgdGhlIFVTQiBUeXBlLUEgY29ubmVjdG9yCm9uIHRoZSBzYW1lIGJvYXJkLiBJ
IGhhdmVuJ3QgdGVzdGVkIHRoZSBVU0IzIHNpZ25hbHMgb24gdGhlIG1pbmktUENJZSwKdGhvdWdo
LCBhcyBJIGhhdmUgbm8gVVNCMyBtaW5pLVBDSWUgZGV2aWNlLgoKYmFydWNoCgo+PiArCXN0YXR1
cyA9ICJva2F5IjsKPj4gK307Cj4+ICsKPj4gICZjcDFfcGluY3RybCB7Cj4+ICAJLyoKPj4gIAkg
KiBNUFAgQnVzOgo+PiAtLQo+PiAyLjE5LjIKPj4KCgotLQogICAgIGh0dHA6Ly9iYXJ1Y2guc2lh
Y2gubmFtZS9ibG9nLyAgICAgICAgICAgICAgICAgIH4uIC5+ICAgVGsgT3BlbiBTeXN0ZW1zCj19
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tb29PLS1VLS1P
b28tLS0tLS0tLS0tLS17PQogICAtIGJhcnVjaEB0a29zLmNvLmlsIC0gdGVsOiArOTcyLjUyLjM2
OC40NjU2LCBodHRwOi8vd3d3LnRrb3MuY28uaWwgLQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
