Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC31EC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:16:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FA2E2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uYOaow9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA2E2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RYwbfye1rfMwnhf7cyU+kvqiXnEnCN4Gw2+qnaR4W9I=; b=uYOaow9PI/QJUG
	eGmKtwxRwyczTIEREx25JSK+81fhc5DdcwnXxgYVjlZnZb1fiDajYdEivpJWaXyjzMfaam2017/2A
	r+3explBskkdnHY9ku5aNtdnkg+1fayDColih34LbegLVTlFZlM2b7GocKe7rwFHR5IBYnrlcVJ1d
	cIeSwvVScZZ+CiU0Ip/3jg5VdWCduAWbufeaJnTmLK2n8e8ibqVSC+igu3HBVuW4Rx4ygNzBW3M2q
	P0x0BOmuAm4nAr6gqJc1sBg+eGDjPh/F47AY2y2h4uQQUEe1pmVcUT04oX2nkiLRAbFF5JzFifBjc
	ajFhCu1Fa6niZjgjtlUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqcF0-0006Sf-Sv; Mon, 04 Feb 2019 11:16:42 +0000
Received: from lhrrgout.huawei.com ([185.176.76.210] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqcEx-0006SK-A9
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 11:16:41 +0000
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id 5A34CD84F6D12B0CEAB5;
 Mon,  4 Feb 2019 11:16:36 +0000 (GMT)
Received: from [127.0.0.1] (10.202.226.46) by LHREML713-CAH.china.huawei.com
 (10.201.108.36) with Microsoft SMTP Server id 14.3.408.0; Mon, 4 Feb 2019
 11:16:28 +0000
Subject: Re: [GIT PULL] arm64: dts: hisilicon dts updates for v5.1
To: <arm@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <olof@lixom.net>, <arnd@arndb.de>
References: <2d2b3aa7-25ef-05e6-7616-506643f4bbf2@hisilicon.com>
From: Wei Xu <xuwei5@hisilicon.com>
Message-ID: <4bdcc188-01c9-934a-5e9d-0e3a55d3304b@hisilicon.com>
Date: Mon, 4 Feb 2019 11:16:26 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <2d2b3aa7-25ef-05e6-7616-506643f4bbf2@hisilicon.com>
Content-Language: en-US
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_031639_501634_6278C86A 
X-CRM114-Status: GOOD (  16.51  )
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
 Vincent Guittot <vincent.guittot@linaro.org>,
 Tangkunshan <tangkunshan@huawei.com>, guodong.xu@linaro.org,
 jinying@hisilicon.com, "Liguozhu \(Kenneth\)" <liguozhu@hisilicon.com>,
 linus.walleij@linaro.org, Jonathan.Cameron@huawei.com, linuxarm@huawei.com,
 shameerali.kolothum.thodi@huawei.com, Alistair Strachan <astrachan@google.com>,
 zhangfei.gao@linaro.org, John Stultz <john.stultz@linaro.org>,
 haojian.zhuang@linaro.org, leo.yan@linaro.org, Jan Kiszka <jan.kiszka@web.de>,
 Shiju Jose <shiju.jose@huawei.com>, Shawn Guo <shawnguo@kernel.org>,
 zhangyi.ac@huawei.com, huangdaode <huangdaode@hisilicon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi ARM-SoC team,

Sorry, there is a patch I forgot to add stable tag.
Please ignore this and I will send a v2.
Sorry for the noise.

Best Regards,
Wei

On 2/1/2019 5:14 PM, Wei Xu wrote:
> Hi ARM-SoC team,
> 
> Please consider to pull the following changes.
> Thanks!
> 
> Best Regards,
> Wei
> 
> ---
> 
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
> 
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
> 
> are available in the Git repository at:
> 
>   git://github.com/hisilicon/linux-hisi.git tags/hisi-arm64-dt-for-5.1
> 
> for you to fetch changes up to 06f439ec7698b3433c15093db28bc72e60a7c85a:
> 
>   arm64: dts: hikey: Revert "Enable HS200 mode on eMMC" (2019-01-31 15:30:25 +0000)
> 
> ----------------------------------------------------------------
> ARM64: DT: Hisilicon SoCs DT updates for 5.1
> 
> * Hi6220 SoC and related boards:
>   - Add DMA entries to enable DMA for Bluetooth transfers
>   - Add power-on delay to make wifi stable
>   - Revert HS200 mode to avoid eMMC controller resets and block read failures
> 
> * Hi3660 SoC and related boards:
>   - Fix SD card detection via setting cd-gpios correctly
> 
> * Hi3798 SoC and related boards:
>   - Fix malformed SPDX license identifier
> 
> ----------------------------------------------------------------
> Alistair Strachan (1):
>       arm64: dts: hikey: Revert "Enable HS200 mode on eMMC"
> 
> Jan Kiszka (1):
>       arm64: dts: hikey: Give wifi some time after power-on
> 
> John Stultz (1):
>       arm64: dts: hikey: Add DMA entries for Bluetooth UART
> 
> Shawn Guo (1):
>       arm64: dts: hi3798cv200: fix malformed SPDX license identifier
> 
> Vincent Guittot (1):
>       arm64: dts: hikey960: fix SDcard detection
> 
>  arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts    | 3 +--
>  arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts | 4 +---
>  arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi       | 4 +---
>  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts       | 2 +-
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi            | 2 ++
>  5 files changed, 6 insertions(+), 9 deletions(-)
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
