Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D579C10F04
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:37:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19826222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f827XXKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19826222A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r3QzpW0NxG1ZftPvwULpLUDQd2vSK/QetWdi6VuetZg=; b=f827XXKqWPpyDq
	pk6c4u2mx/fZ1JLOybwY/2o3oVHgnJWJr2oAaWSlDzGUbcb8jwuOrz9kP4B05NaDLftIRZDtw4rzk
	qu+0ThX/g73I2yQ+cwV4RhsAo3TKSzO95mSY5A2+0rWNXLt9Fnj/J8NXUn+aLbVk+nuHZhCvCl9hr
	rNaFetHy89+k6Paq39h2icbNP/zXErlYQIaDXZahOtGMD64yy7t44qJBCmmmBbvgryh8kFhQa6Ite
	erEn01sKB29ij1TIrevQJhvB4Y3FRzmgLblx8WKfX4UFNdQrDkWwMdhdTSatu+XDm3Pw18QzLE/CX
	jTSL1cWp9Js23FKr85mg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guAeE-0006B0-1J; Thu, 14 Feb 2019 06:37:26 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guAe4-0005xk-VX
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 06:37:20 +0000
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id 2B6C4177AAF109FCAA99;
 Thu, 14 Feb 2019 14:37:14 +0800 (CST)
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.222]) by
 DGGEMM403-HUB.china.huawei.com ([10.3.20.211]) with mapi id 14.03.0415.000;
 Thu, 14 Feb 2019 14:37:12 +0800
From: "liwei (CM)" <liwei213@huawei.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 "vinholikatti@gmail.com" <vinholikatti@gmail.com>, "jejb@linux.vnet.ibm.com"
 <jejb@linux.vnet.ibm.com>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIHYyIDIvM10gYXJtNjQ6IGR0czogaGlzaWxpY29uOiBo?=
 =?gb2312?Q?i3670:_Add_UFS_controller_support?=
Thread-Topic: [PATCH v2 2/3] arm64: dts: hisilicon: hi3670: Add UFS
 controller support
Thread-Index: AQHUpMhqsIxwTfArFk+ccYDgjfW3NqXfFdiw
Date: Thu, 14 Feb 2019 06:37:11 +0000
Message-ID: <1699CE87DE933F49876AD744B5DC140F0672AA14@dggemm526-mbx.china.huawei.com>
References: <20190105072859.9134-1-manivannan.sadhasivam@linaro.org>
 <20190105072859.9134-3-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190105072859.9134-3-manivannan.sadhasivam@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.189.155.72]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_223717_442505_291F858E 
X-CRM114-Status: GOOD (  10.65  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
 "john.stultz@linaro.org" <john.stultz@linaro.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RmluZSB0byBtZS4gVGhhbmtzIQ0KQWNrZWQtYnk6IFdlaSBMaSA8bGl3ZWkyMTNAaHVhd2VpLmNv
bT4NCg0KLS0tLS3Tyrz+1K28/i0tLS0tDQq3orz+yMs6IE1hbml2YW5uYW4gU2FkaGFzaXZhbSBb
bWFpbHRvOm1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnXSANCreiy83KsbzkOiAyMDE5
xOox1MI1yNUgMTU6MjkNCsrVvP7IyzogdmluaG9saWthdHRpQGdtYWlsLmNvbTsgamVqYkBsaW51
eC52bmV0LmlibS5jb207IG1hcnRpbi5wZXRlcnNlbkBvcmFjbGUuY29tOyBsaXdlaSAoQ00pOyBy
b2JoK2R0QGtlcm5lbC5vcmcNCrOty806IGxpbnV4LXNjc2lAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBqb2huLnN0dWx0ekBsaW5hcm8ub3Jn
OyBhbWl0Lmt1Y2hlcmlhQGxpbmFyby5vcmc7IGd1b2RvbmcueHVAbGluYXJvLm9yZzsgTWFuaXZh
bm5hbiBTYWRoYXNpdmFtDQrW98ziOiBbUEFUQ0ggdjIgMi8zXSBhcm02NDogZHRzOiBoaXNpbGlj
b246IGhpMzY3MDogQWRkIFVGUyBjb250cm9sbGVyIHN1cHBvcnQNCg0KQWRkIFVGUyBjb250cm9s
bGVyIHN1cHBvcnQgZm9yIEhpU2lsaWNvbiBISTM2NzAgU29DLg0KDQpTaWduZWQtb2ZmLWJ5OiBN
YW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0K
LS0tDQogYXJjaC9hcm02NC9ib290L2R0cy9oaXNpbGljb24vaGkzNjcwLmR0c2kgfCAxOCArKysr
KysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKQ0KDQpkaWZm
IC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9oaXNpbGljb24vaGkzNjcwLmR0c2kgYi9hcmNo
L2FybTY0L2Jvb3QvZHRzL2hpc2lsaWNvbi9oaTM2NzAuZHRzaQ0KaW5kZXggNmNjZGY1MDQwZmZk
Li4yODUyMTlkZDY1N2YgMTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2hpc2lsaWNv
bi9oaTM2NzAuZHRzaQ0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9oaXNpbGljb24vaGkzNjcw
LmR0c2kNCkBAIC02NTQsNiArNjU0LDI0IEBADQogCQkJY2xvY2stbmFtZXMgPSAiYXBiX3BjbGsi
Ow0KIAkJfTsNCiANCisJCS8qIFVGUyAqLw0KKwkJdWZzOiB1ZnNAZmYzYzAwMDAgew0KKwkJCWNv
bXBhdGlibGUgPSAiaGlzaWxpY29uLGhpMzY3MC11ZnMiLCAiamVkZWMsdWZzLTIuMSI7DQorCQkJ
LyogMDogSENJIHN0YW5kYXJkICovDQorCQkJLyogMTogVUZTIFNZUyBDVFJMICovDQorCQkJcmVn
ID0gPDB4MCAweGZmM2MwMDAwIDB4MCAweDEwMDA+LA0KKwkJCQk8MHgwIDB4ZmYzZTAwMDAgMHgw
IDB4MTAwMD47DQorCQkJaW50ZXJydXB0LXBhcmVudCA9IDwmZ2ljPjsNCisJCQlpbnRlcnJ1cHRz
ID0gPEdJQ19TUEkgMjc4IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KKwkJCWNsb2NrcyA9IDwmY3Jn
X2N0cmwgSEkzNjcwX0NMS19HQVRFX1VGU0lPX1JFRj4sDQorCQkJCTwmY3JnX2N0cmwgSEkzNjcw
X0NMS19HQVRFX1VGU19TVUJTWVM+Ow0KKwkJCWNsb2NrLW5hbWVzID0gInJlZl9jbGsiLCAicGh5
X2NsayI7DQorCQkJZnJlcS10YWJsZS1oeiA9IDwwIDA+LCA8MCAwPjsNCisJCQkvKiBvZmZzZXQ6
IDB4ODQ7IGJpdDogMTIgKi8NCisJCQlyZXNldHMgPSA8JmNyZ19yc3QgMHg4NCAxMj47DQorCQkJ
cmVzZXQtbmFtZXMgPSAicnN0IjsNCisJCX07DQorDQogCQkvKiBTRCAqLw0KIAkJZHdtbWMxOiBk
d21tYzFAZmYzN2YwMDAgew0KIAkJCWNvbXBhdGlibGUgPSAiaGlzaWxpY29uLGhpMzY3MC1kdy1t
c2hjIjsNCi0tIA0KMi4xNy4xDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
