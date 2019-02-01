Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A38EC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:14:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AAD32082E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Otqe3fe6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AAD32082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:
	From:To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=cslgEZ1VWpWliOvIZk36J87NiXILSQSUBF9iDRslyEc=; b=Otqe3fe6Y8my3A
	OaPDradvPhLTH99wB1BXrBAA4+WY5vh3emiCpTe6Xckjb98bl0fuboQ5ghydjPvwh0lihUSSNMESO
	hOI3S4Jl+TMTb65b5elogxh7oJhDWC013ZchDILeNPt8buiuYFuFXIxQWwRr2p5caJP2rWQh8c0WL
	Wk9FjXaJ4BxAjG1pwDG3gGgMDYRmfxZwqPFL9mMJZdkS9kcF3Suy4NEL4PbmWsOjo8NQU9tw1sv6j
	8gse7yOx9cWDyL+o9Mdpx+HzSXINJqrW/cSV+CyZ7+lc2/r7wCGHhnhFVoJEo0WZtXJkLu5VvUFUZ
	LMxWUT8Y7M23S7V4voEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpcOg-00019x-G1; Fri, 01 Feb 2019 17:14:34 +0000
Received: from lhrrgout.huawei.com ([185.176.76.210] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpcOc-00018y-Vs
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 17:14:32 +0000
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id 7BBDA225F1053B31B778;
 Fri,  1 Feb 2019 17:14:26 +0000 (GMT)
Received: from [127.0.0.1] (10.202.226.46) by LHREML710-CAH.china.huawei.com
 (10.201.108.33) with Microsoft SMTP Server id 14.3.408.0; Fri, 1 Feb 2019
 17:14:19 +0000
To: <arm@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <olof@lixom.net>, <arnd@arndb.de>
From: Wei Xu <xuwei5@hisilicon.com>
Subject: [GIT PULL] arm64: dts: hisilicon dts updates for v5.1
Message-ID: <2d2b3aa7-25ef-05e6-7616-506643f4bbf2@hisilicon.com>
Date: Fri, 1 Feb 2019 17:14:17 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Language: en-US
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_091431_177697_625F644D 
X-CRM114-Status: GOOD (  10.94  )
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
Cc: Tangkunshan <tangkunshan@huawei.com>, linus.walleij@linaro.org,
 linuxarm@huawei.com, haojian.zhuang@linaro.org,
 Vincent Guittot <vincent.guittot@linaro.org>, xuwei5@hisilicon.com,
 huangdaode <huangdaode@hisilicon.com>, zhangfei.gao@linaro.org,
 zhangyi.ac@huawei.com, jinying@hisilicon.com, John
 Garry <john.garry@huawei.com>, John Stultz <john.stultz@linaro.org>,
 Jonathan.Cameron@huawei.com, Salil Mehta <salil.mehta@huawei.com>,
 guodong.xu@linaro.org, Shawn Guo <shawnguo@kernel.org>,
 Alistair Strachan <astrachan@google.com>, shameerali.kolothum.thodi@huawei.com,
 leo.yan@linaro.org, Jan Kiszka <jan.kiszka@web.de>,
 "Liguozhu \(Kenneth\)" <liguozhu@hisilicon.com>, Shiju
 Jose <shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi ARM-SoC team,

Please consider to pull the following changes.
Thanks!

Best Regards,
Wei

---

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hisi-arm64-dt-for-5.1

for you to fetch changes up to 06f439ec7698b3433c15093db28bc72e60a7c85a:

  arm64: dts: hikey: Revert "Enable HS200 mode on eMMC" (2019-01-31 15:30:25 +0000)

----------------------------------------------------------------
ARM64: DT: Hisilicon SoCs DT updates for 5.1

* Hi6220 SoC and related boards:
  - Add DMA entries to enable DMA for Bluetooth transfers
  - Add power-on delay to make wifi stable
  - Revert HS200 mode to avoid eMMC controller resets and block read failures

* Hi3660 SoC and related boards:
  - Fix SD card detection via setting cd-gpios correctly

* Hi3798 SoC and related boards:
  - Fix malformed SPDX license identifier

----------------------------------------------------------------
Alistair Strachan (1):
      arm64: dts: hikey: Revert "Enable HS200 mode on eMMC"

Jan Kiszka (1):
      arm64: dts: hikey: Give wifi some time after power-on

John Stultz (1):
      arm64: dts: hikey: Add DMA entries for Bluetooth UART

Shawn Guo (1):
      arm64: dts: hi3798cv200: fix malformed SPDX license identifier

Vincent Guittot (1):
      arm64: dts: hikey960: fix SDcard detection

 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts    | 3 +--
 arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts | 4 +---
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi       | 4 +---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts       | 2 +-
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi            | 2 ++
 5 files changed, 6 insertions(+), 9 deletions(-)


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
