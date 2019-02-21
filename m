Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963CBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:04:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 645122147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XXoW5oUg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 645122147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=grZ7S2RQhqX3dTvdxrBKDsXr7kvABM0N6/hSvT6UEuY=; b=XXoW5oUgLQ0Pa3
	v/W5Vz+fp0TYR5qmIlr4ABnhj/AMrmthCrB+0s/l3OAgnC+2x5m5qlgLjVfXDg16QclGI2tSEq11i
	X9i/pihRErgV5+6D58ISTlGKAYLtAN+6ekfeRtbs4bST3ohoEuEaK9bq1JjLDkEBad+Zk4LATFcpv
	1Hzkt51B57vxpEp/deMNkIVcCWdUyZw8SCs1Z6ziUn+PAvkX41xDb4cQS69BxVVff/I2IUrCmFwHt
	vbCumiRDadSfe8Ww80UY2IeNV24Yu0ufdO0rN4fk/JmPnYYahmA9PcZhg/XsMMiQtLcJQDVfbMEq3
	Jwt/L4fq3Uq/LHMasbxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwlDk-0001ik-DH; Thu, 21 Feb 2019 10:04:48 +0000
Received: from relay11.mail.gandi.net ([217.70.178.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwlBo-0007Xo-V4; Thu, 21 Feb 2019 10:02:58 +0000
Received: from localhost.localdomain
 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay11.mail.gandi.net (Postfix) with ESMTPSA id 856C4100003;
 Thu, 21 Feb 2019 10:02:44 +0000 (UTC)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>,
 Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: [RFC PATCH 08/27] mtd: nand: ecc: Use SPDX license identifier for the
 software BCH code
Date: Thu, 21 Feb 2019 11:01:57 +0100
Message-Id: <20190221100216.25255-9-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190221100216.25255-1-miquel.raynal@bootlin.com>
References: <20190221100216.25255-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_020249_787490_5E35E97C 
X-CRM114-Status: GOOD (  14.34  )
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
Cc: Vignesh R <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@microchip.com>,
 Julien Su <juliensu@mxic.com.tw>,
 Schrempf Frieder <frieder.schrempf@kontron.de>, linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Mason Yang <masonccyang@mxic.com.tw>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

UmVtb3ZlIHRoZSBsZWdhY3kgbGljZW5zZSB0ZXh0LCBhbHNvIHVwZGF0ZSB0aGUgTU9EVUxFX0xJ
Q0VOU0UgbWFjcm8KaW4gYWNjb3JkYW5jZSB3aXRoIHRoZSB0ZXh0IGF0IHRoZSB0b3Agb2YgdGhl
IGZpbGUgKEdQTCB2MiBvcgpoaWdoZXIpLgoKU2lnbmVkLW9mZi1ieTogTWlxdWVsIFJheW5hbCA8
bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4KLS0tCiBkcml2ZXJzL210ZC9uYW5kL2VjYy9zdy1i
Y2gtZW5naW5lLmMgICB8IDE3ICsrLS0tLS0tLS0tLS0tLS0tCiBpbmNsdWRlL2xpbnV4L210ZC9u
YW5kLXN3LWJjaC1lbmdpbmUuaCB8ICA1ICstLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvbmFuZC9l
Y2Mvc3ctYmNoLWVuZ2luZS5jIGIvZHJpdmVycy9tdGQvbmFuZC9lY2Mvc3ctYmNoLWVuZ2luZS5j
CmluZGV4IDM3ZGMwZjAwNjFkMy4uODcxYzRkZDlmNzFkIDEwMDY0NAotLS0gYS9kcml2ZXJzL210
ZC9uYW5kL2VjYy9zdy1iY2gtZW5naW5lLmMKKysrIGIvZHJpdmVycy9tdGQvbmFuZC9lY2Mvc3ct
YmNoLWVuZ2luZS5jCkBAIC0xLDIyICsxLDkgQEAKKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wKwogLyoKICAqIFRoaXMgZmlsZSBwcm92aWRlcyBFQ0MgY29ycmVjdGlvbiBmb3Ig
bW9yZSB0aGFuIDEgYml0IHBlciBibG9jayBvZiBkYXRhLAogICogdXNpbmcgYmluYXJ5IEJDSCBj
b2Rlcy4gSXQgcmVsaWVzIG9uIHRoZSBnZW5lcmljIEJDSCBsaWJyYXJ5IGxpYi9iY2guYy4KICAq
CiAgKiBDb3B5cmlnaHQgwqkgMjAxMSBJdmFuIERqZWxpYyA8aXZhbi5kamVsaWNAcGFycm90LmNv
bT4KLSAqCi0gKiBUaGlzIGZpbGUgaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1
dGUgaXQgYW5kL29yIG1vZGlmeSBpdAotICogdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2Vu
ZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkgdGhlCi0gKiBGcmVlIFNvZnR3YXJl
IEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb3IgKGF0IHlvdXIgb3B0aW9uKSBhbnkKLSAq
IGxhdGVyIHZlcnNpb24uCi0gKgotICogVGhpcyBmaWxlIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBo
b3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsIGJ1dCBXSVRIT1VUCi0gKiBBTlkgV0FSUkFOVFk7
IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZiBNRVJDSEFOVEFCSUxJVFkgb3IK
LSAqIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZSBHTlUgR2VuZXJh
bCBQdWJsaWMgTGljZW5zZQotICogZm9yIG1vcmUgZGV0YWlscy4KLSAqCi0gKiBZb3Ugc2hvdWxk
IGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBh
bG9uZwotICogd2l0aCB0aGlzIGZpbGU7IGlmIG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUgU29mdHdh
cmUgRm91bmRhdGlvbiwgSW5jLiwKLSAqIDU5IFRlbXBsZSBQbGFjZSwgU3VpdGUgMzMwLCBCb3N0
b24sIE1BIDAyMTExLTEzMDcgVVNBLgogICovCiAKICNpbmNsdWRlIDxsaW51eC90eXBlcy5oPgpA
QCAtMjI3LDYgKzIxNCw2IEBAIHZvaWQgbmFuZF9iY2hfZnJlZShzdHJ1Y3QgbmFuZF9iY2hfY29u
dHJvbCAqbmJjKQogfQogRVhQT1JUX1NZTUJPTChuYW5kX2JjaF9mcmVlKTsKIAotTU9EVUxFX0xJ
Q0VOU0UoIkdQTCIpOworTU9EVUxFX0xJQ0VOU0UoIkdQTCB2MiIpOwogTU9EVUxFX0FVVEhPUigi
SXZhbiBEamVsaWMgPGl2YW4uZGplbGljQHBhcnJvdC5jb20+Iik7CiBNT0RVTEVfREVTQ1JJUFRJ
T04oIk5BTkQgc29mdHdhcmUgQkNIIEVDQyBzdXBwb3J0Iik7CmRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L210ZC9uYW5kLXN3LWJjaC1lbmdpbmUuaCBiL2luY2x1ZGUvbGludXgvbXRkL25hbmQt
c3ctYmNoLWVuZ2luZS5oCmluZGV4IGE2ODJhMTVmYTE2NS4uMTIxMDdhYTdjMzcxIDEwMDY0NAot
LS0gYS9pbmNsdWRlL2xpbnV4L210ZC9uYW5kLXN3LWJjaC1lbmdpbmUuaAorKysgYi9pbmNsdWRl
L2xpbnV4L210ZC9uYW5kLXN3LWJjaC1lbmdpbmUuaApAQCAtMSwxMCArMSw3IEBACisvKiBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCAqLwogLyoKICAqIENvcHlyaWdodCDCqSAyMDEx
IEl2YW4gRGplbGljIDxpdmFuLmRqZWxpY0BwYXJyb3QuY29tPgogICoKLSAqIFRoaXMgcHJvZ3Jh
bSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5
Ci0gKiBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNl
IHZlcnNpb24gMiBhcwotICogcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRp
b24uCi0gKgogICogVGhpcyBmaWxlIGlzIHRoZSBoZWFkZXIgZm9yIHRoZSBOQU5EIEJDSCBFQ0Mg
aW1wbGVtZW50YXRpb24uCiAgKi8KIAotLSAKMi4xOS4xCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QK
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
