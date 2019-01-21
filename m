Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98168C31D64
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 04:18:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61B1620844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 04:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ns0pg0ZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B1620844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WoMW64VsqywwzNFmbXnoy3VYf7rhracrs/3IF8jv3ag=; b=Ns0pg0ZHjWkiK4
	zSZLi8YwDFcUVgixYbNC5qM3UC9dhuQq4XckL7NqHOSa/8L6vg9T1e+QCHwCCpIAm/hARcybZgfVW
	VmM7O54VP5Md6y7uylG6IJFEHFDNeXypmL+Ywo/0q77rr+ng9575tpCWcJ3/BT4S7PsBQj0LUoV/4
	DoRu4YRDCr+aOgxRST+Qf89nqDyRaju04XoHdwNYYNzh3vVPTxtp7mDOvis+Gmnyjpm/OZ1PNzEeo
	q1svBBTu0AvxfoS7PbUEEOC1T6pYbRj9BcWOFlfQ8dUQ68Pxkq0JH888OiYOc3jkXRQAeyQb+lpak
	50MbcEWanX28AZM0qafQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glR29-0003SF-47; Mon, 21 Jan 2019 04:18:01 +0000
Received: from mail-sh.amlogic.com ([58.32.228.43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glR1t-0003IK-P7; Mon, 21 Jan 2019 04:17:47 +0000
Received: from [10.18.29.210] (10.18.29.210) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1591.10; Mon, 21 Jan
 2019 12:18:18 +0800
Subject: Re: [PATCH] MAINTAINERS: Add entry for Amlogic NAND controller driver
To: Miquel Raynal <miquel.raynal@bootlin.com>
References: <1547917355-13179-1-git-send-email-jianxin.pan@amlogic.com>
 <20190120160605.33689354@xps13>
From: Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <3f098e44-9d9b-3d0a-3e19-5913077aeb07@amlogic.com>
Date: Mon, 21 Jan 2019 12:18:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190120160605.33689354@xps13>
Content-Language: en-US
X-Originating-IP: [10.18.29.210]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh.amlogic.com
 (10.18.11.5)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_201745_815978_054B414D 
X-CRM114-Status: GOOD (  12.56  )
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

SGkgTWlxdWVsLAoKT24gMjAxOS8xLzIwIDIzOjA2LCBNaXF1ZWwgUmF5bmFsIHdyb3RlOgo+IEhp
IEppYW54aW4sCj4gCj4gSmlhbnhpbiBQYW4gPGppYW54aW4ucGFuQGFtbG9naWMuY29tPiB3cm90
ZSBvbiBTdW4sIDIwIEphbiAyMDE5Cj4gMDE6MDI6MzUgKzA4MDA6Cj4gCj4+IEFkZCBlbnRyeSBm
b3IgQW1sb2dpYyBOQU5EIGNvbnRyb2xsZXIgZHJpdmVyIGFuZCBpdHMgYmluZGluZ3NbMF0uCj4+
Cj4+IFswXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzE1NDc1NjY2ODQtNTc0NzItMS1n
aXQtc2VuZC1lbWFpbC1qaWFueGluLnBhbkBhbWxvZ2ljLmNvbS8KPj4KPj4gU2lnbmVkLW9mZi1i
eTogTGlhbmcgWWFuZyA8bGlhbmcueWFuZ0BhbWxvZ2ljLmNvbT4KPj4gU2lnbmVkLW9mZi1ieTog
SmlhbnhpbiBQYW4gPGppYW54aW4ucGFuQGFtbG9naWMuY29tPgo+IAo+IElmIHlvdSBhcmUgdGhl
IGF1dGhvciBvZiB0aGUgcGF0Y2ggeW91ciBTaWduZWQtb2ZmLWJ5IHNob3VsZCBjb21lIGZpcnN0
LgpPSy4KPiAKPiBBbHNvLCB3aHkgaXMgTGlhbmcgdGhlIE1haW50YWluZXI/IFdoeSBub3QgeW91
Pwo+IApZYW5nbGlhbmcgaXMgQW1sb2dpYyBtYWludGFpbmVyIGZvciBOQU5EIGNvbnRyb2xsZXIu
IEFuZCBhbGwgcGF0Y2hlcyBhYm91dCBhbWxvZ2ljIE5BTkQgY29udHJvbGxlciBhcmUgZnJvbSBo
aW0uCj4+IC0tLQo+PiAgTUFJTlRBSU5FUlMgfCA3ICsrKysrKysKPj4gIDEgZmlsZSBjaGFuZ2Vk
LCA3IGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRB
SU5FUlMKPj4gaW5kZXggMGFiZWNjNS4uN2Q5NzZhMSAxMDA2NDQKPj4gLS0tIGEvTUFJTlRBSU5F
UlMKPj4gKysrIGIvTUFJTlRBSU5FUlMKPj4gQEAgLTk2MjgsNiArOTYyOCwxMyBAQCBGOglkcml2
ZXJzL21lZGlhL3BsYXRmb3JtL21lc29uL2FvLWNlYy5jCj4+ICBGOglEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbWVkaWEvbWVzb24tYW8tY2VjLnR4dAo+PiAgVDoJZ2l0IGdpdDov
L2xpbnV4dHYub3JnL21lZGlhX3RyZWUuZ2l0Cj4+ICAKPj4gK01FU09OIE5BTkQgQ09OVFJPTExF
UiBEUklWRVIgRk9SIEFNTE9HSUMgU09DUwo+PiArTToJTGlhbmcgWWFuZyA8bGlhbmcueWFuZ0Bh
bWxvZ2ljLmNvbT4KPj4gK0w6CWxpbnV4LW10ZEBsaXN0cy5pbmZyYWRlYWQub3JnCj4+ICtTOglN
YWludGFpbmVkCj4+ICtGOglkcml2ZXJzL210ZC9uYW5kL3Jhdy9tZXNvbl8qCj4+ICtGOglEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL2FtbG9naWMsbWVzb24tbmFuZC50eHQK
Pj4gKwo+PiAgTUlDUk9CTEFaRSBBUkNISVRFQ1RVUkUKPj4gIE06CU1pY2hhbCBTaW1layA8bW9u
c3RyQG1vbnN0ci5ldT4KPj4gIFc6CWh0dHA6Ly93d3cubW9uc3RyLmV1L2ZkdC8KPiAKPiBUaGFu
a3MsCj4gTWlxdcOobAo+IAo+IC4KPiAKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
