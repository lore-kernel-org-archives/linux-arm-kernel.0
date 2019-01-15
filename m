Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDD7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 06:11:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5405520859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 06:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eKnQCEQ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5405520859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=milecki.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-ID:References:In-Reply-To:Subject:To:From:
	Date:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kXk4MVjwWKeb157SF1EKpe85NkJTfapIpdVwIpEyEmQ=; b=eKnQCEQ1ae2jB2YDRjFa2GRvn
	BakP1GoahBs4t0iFOF3Q+4/9SURsRG8H5+q4C1R6UUws1LgYtXEnpvDcnj6RmAm89vEY3250JmH+2
	hLNbEsUC43ldYYpFJcw8kIT1btH8Mf59LhUdF7+UMIQs68dYMvXydXYpsSyBsFu96A37il0c8mBM9
	F66QMP4LxwGk455m6CQuhy8r8zI+hUwCD9aWEOsF1EdvfheL8+xxr2GDK8CbgJ9y+ROczRlMCKhEf
	f89FctH+YcZPisrk4qG8xWzLjUHTBoTX1n7OrJbDs1NWIsx/HuOC5M7i5jGp8+h6x8sORZ6JmTdXw
	V3/VPIP2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjHwI-0000dm-BU; Tue, 15 Jan 2019 06:11:06 +0000
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjHwD-0000cx-F4
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 06:11:03 +0000
Received: from player789.ha.ovh.net (unknown [10.109.159.62])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 64DC817A870
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 07:10:55 +0100 (CET)
Received: from RCM-web4.webmail.mail.ovh.net
 (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
 (Authenticated sender: rafal@milecki.pl)
 by player789.ha.ovh.net (Postfix) with ESMTPSA id 3734419AAD12;
 Tue, 15 Jan 2019 06:10:48 +0000 (UTC)
MIME-Version: 1.0
Date: Tue, 15 Jan 2019 07:10:45 +0100
From: =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] ARM: dts: BCM53573: Relicense Luxul files to the GPL 2.0+
 / MIT
In-Reply-To: <158e0161-0d94-54a9-3851-9a3e65e85b77@gmail.com>
References: <1543795215-31863-1-git-send-email-dan.haab@luxul.com>
 <1abbf738f6ac9808310e27a43f430cc9@milecki.pl>
 <158e0161-0d94-54a9-3851-9a3e65e85b77@gmail.com>
Message-ID: <b72a3624209f93f9ceb363b886a88f79@milecki.pl>
X-Sender: rafal@milecki.pl
User-Agent: Roundcube Webmail/1.3.8
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
X-Ovh-Tracer-Id: 8749931127886417647
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrgedvgdeludcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_221101_647233_F251A4E7 
X-CRM114-Status: GOOD (  10.92  )
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
 Dan Haab <riproute@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Dan Haab <dan.haab@luxul.com>, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMjAxOS0wMS0xNCAxOToyNiwgRmxvcmlhbiBGYWluZWxsaSB3cm90ZToKPiBPbiAxLzEzLzE5
IDExOjE1IFBNLCBSYWZhxYIgTWnFgmVja2kgd3JvdGU6Cj4+IE9uIDIwMTgtMTItMDMgMDE6MDAs
IERhbiBIYWFiIHdyb3RlOgo+Pj4gVGhpcyBtYXRjaGVzIGxpY2Vuc2luZyB1c2VkIGJ5IG90aGVy
IEJDTTUzNTczIGZpbGVzIGFuZCBCQ001MzAxWC4KPj4+IAo+Pj4gU2lnbmVkLW9mZi1ieTogRGFu
IEhhYWIgPGRhbi5oYWFiQGx1eHVsLmNvbT4KPj4gCj4+IEFja2VkLWJ5OiBSYWZhxYIgTWnFgmVj
a2kgPHJhZmFsQG1pbGVja2kucGw+Cj4+IAo+PiBGbG9yaWFuOiBwaW5nIDopCj4gCj4gSWYgYmNt
LWtlcm5lbC1mZWVkYmFjay1saXN0QGJyb2FkY29tLmNvbSBpcyBub3QgY29waWVkLCB0aGVuIG91
cgo+IHBhdGNod29yayBpbnN0YW5jZSBkb2VzIG5vdCBwaWNrIHVwIHRoYXQgcGF0Y2gsIGFuZCB0
aGVyZSBpcyBhIHJlbW90ZQo+IGNoYW5jZSB0aGluZ3MgY2FuIGdldCBsb3N0Li4uIE5vdCB0cnlp
bmcgdG8gdXNlIHRoYXQgYXMgYW4gZXhjdXNlIGZvcgo+IG5vdCBoYXZpbmcgc2VlbiB0aGlzLCBi
dXQgcGxlYXNlIG1ha2Ugc3VyZSB5b3UgY29weSB0aGF0IGxpc3QgdG8KPiBtYXhpbWl6ZSB0aGUg
bGlrZWxpaG9vZCBvZiBnZXR0aW5nIHBhdGNoZXMgYWNjZXB0ZWQuCgpQZXJoYXBzIHdlIHNob3Vs
ZCBhZGQgYmNtLWtlcm5lbC1mZWVkYmFjay1saXN0QCB0byB0aGUKQlJPQURDT00gQkNNNTM1NzMg
QVJNIEFSQ0hJVEVDVFVSRQplbnRyeSBpbiBNQUlOVEFJTkVSUz8gV291bGQgeW91IG1pbmQgaGFu
ZGxpbmcgdGhhdD8KCj4gTm93IGFwcGxpZWQsIHRoYW5rcyEKClRoYW5rcyEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFp
bGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
