Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09802C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:52:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC42220868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MvBb5OpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC42220868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:
	From:To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=0BcDqIUGrFd2PH3L8msmds7dwmh6gmVxmBARagk12x0=; b=MvBb5OpU4i4G0r
	GOkgmTFTbrlZJ9SlFeeG7b752od7XhpmbkimoBcGduKhfUJ0kEFPvanjNyDk8CyTDZvCflek7xEEB
	8pC4ZEkJtF1tQ/VUpGRRxFKzl3GTlm43Egs5e+xvvTr3gr8YSsDLBOanohK7j56a+Tiz30N0qn93f
	ayVoJ/pA7azdOhva9qjrzEcpwC7ioPYQLCLfgyhkvIIjOIdxSmh7H0OrOwzHVeODFf7qI7b2b3mOf
	o2drSIs4zUFf4YixTb2rhtbMxJAZ4oEHypwK9dys3yxxVacXoaNoXwZYkfgMeVO0tgBN6bv/FYL/0
	euOXcwRCaGKxMaTr+a+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSOc8-00076V-Cr; Thu, 29 Nov 2018 15:52:28 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSOc2-0006of-Si
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 15:52:24 +0000
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 4B67E7A9584C7;
 Thu, 29 Nov 2018 23:52:08 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.42) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Thu, 29 Nov 2018
 23:52:02 +0800
To: "arm@kernel.org" <arm@kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Olof Johansson <olof@lixom.net>,
 "Arnd Bergmann" <arnd@arndb.de>
From: Wei Xu <xuwei5@hisilicon.com>
Subject: [GIT PULL] arm64: dts: hisilicon dts updates for v4.21
Message-ID: <5C000B15.8010400@hisilicon.com>
Date: Thu, 29 Nov 2018 15:51:49 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_075223_148922_C463A386 
X-CRM114-Status: GOOD (  12.17  )
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
Cc: Salil Mehta <salil.mehta@huawei.com>, John Garry <john.garry@huawei.com>,
 jinying@hisilicon.com,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Guodong Xu <guodong.xu@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, Manivannan
 Sadhasivam <manivannan.sadhasivam@linaro.org>, Linuxarm <linuxarm@huawei.com>,
 xuwei5@hisilicon.com, "Chenxin \(Charles\)" <charles.chenxin@huawei.com>,
 "haojian.zhuang@linaro.org" <haojian.zhuang@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Leo Yan <leo.yan@linaro.org>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 Shiju Jose <shiju.jose@huawei.com>, "Liguozhu
 \(Kenneth\)" <liguozhu@hisilicon.com>, Zhangyi ac <zhangyi.ac@huawei.com>,
 Tangkunshan <tangkunshan@huawei.com>, Daode Huang <huangdaode@hisilicon.com>
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

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hisi-arm64-dt-for-4.21

for you to fetch changes up to 6ad5506ed191eefec7d205245edabb8b5f7e950f:

  ARM64: dts: hisilicon: Add all CPUs in cooling maps (2018-11-29 10:11:21 +0000)

----------------------------------------------------------------
ARM64: DT: Hisilicon SoCs DT updates for 4.21

* Hi3660 SoC and related boards:
  - Standardize LED labels and triggers for the hikey960 board
  - Add the missing cooling-cells property for the cpu nodes
  - Add all cpus into the cooling maps

* Hi3670 SoC and related boards:
  - Add clock nodes and update the uart clock
  - Add Pinctrl, GPIO and uart nodes
  - Enable uart and add GPIO line names for the hikey970 board

* Hi3798 SoC and related boards:
  - Standardize LED labels and triggers for the poplar board

* Hi6220 SoC and related boards:
  - Standardize LED labels and triggers for the hikey board
  - Add all cpus into the cooling maps

----------------------------------------------------------------
Manivannan Sadhasivam (10):
      arm64: dts: hisilicon: Add clock nodes for Hi3670 SoC
      arm64: dts: hisilicon: Source SoC clock for UART6
      arm64: dts: hisilicon: Add Pinctrl support for HiKey970 board
      arm64: dts: hisilicon: hi3670: Add GPIO controller support
      arm64: dts: hisilicon: hi3670: Add UART nodes
      arm64: dts: hisilicon: hikey970: Enable on-board UARTs
      arm64: dts: hisilicon: hikey970: Add GPIO line names
      arm64: dts: hisilicon: hikey: Standardize LED labels and triggers
      arm64: dts: hisilicon: hikey960: Standardize LED labels and triggers
      arm64: dts: hisilicon: poplar: Standardize LED labels and triggers

Viresh Kumar (2):
      arm64: dts: hi3660: Add missing cooling device properties for CPUs
      ARM64: dts: hisilicon: Add all CPUs in cooling maps

 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts  |  18 +-
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |  16 +-
 arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts  | 338 ++++++++++++++
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi          | 499 ++++++++++++++++++++-
 .../boot/dts/hisilicon/hi3798cv200-poplar.dts      |  13 +-
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts     |  25 +-
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |   9 +-
 .../arm64/boot/dts/hisilicon/hikey970-pinctrl.dtsi | 244 ++++++++++
 8 files changed, 1127 insertions(+), 35 deletions(-)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hikey970-pinctrl.dtsi


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
