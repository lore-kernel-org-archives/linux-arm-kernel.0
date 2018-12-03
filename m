Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3134AC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:41:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02E2F20659
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gjfaBdCS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02E2F20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1nsNY0jiGuyIZQtOuTTLmBmzu/G1phrb6twqoreFvic=; b=gjfaBdCS01hESr
	zVPRXRA+EcmBcSPRDgcGqRnamkXGzp2v2TnA7nt57bpoIPLWWFt1YMCUEzcjctyMeg7EvWijLPa3c
	OkfHR7V4X0PmroNxVp4jpbtUf+Z+KAYgn0UHYqOfGBg53fdEYP4V+RhEA8MjdKZJesCyGSCECIgQ2
	gwP5QrZo4Sma+g/Hk8k6HNNGBO7bBADJl7wi0bZOkxxEPpguOkPwHV5UQf/QIfRmfKMFKK7eJrYFl
	Hklh5s+gffBzFNPIKRj2DxX/jnlwHv1aC75d89PXVpM5TT1od3VWW4t1Ec1925Eao1x3DQ3TQh+Hd
	zEFyoPXF/PrnDn7Al0Pw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTpP6-00071g-Mb; Mon, 03 Dec 2018 14:40:56 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTpOz-0006x5-OS
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 14:40:54 +0000
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 64BC9C5EBA9BA;
 Mon,  3 Dec 2018 22:40:29 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.42) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Mon, 3 Dec 2018
 22:40:21 +0800
Subject: Re: [GIT PULL] arm64: dts: hisilicon dts updates for v4.21
To: Olof Johansson <olof@lixom.net>
References: <5C000B15.8010400@hisilicon.com>
 <20181130234652.dfv5onq3s4faweut@localhost>
From: Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5C05404A.4070806@hisilicon.com>
Date: Mon, 3 Dec 2018 14:40:10 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20181130234652.dfv5onq3s4faweut@localhost>
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_064052_975199_27860CC9 
X-CRM114-Status: GOOD (  12.21  )
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
Cc: Tangkunshan <tangkunshan@huawei.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, Linuxarm <linuxarm@huawei.com>,
 "haojian.zhuang@linaro.org" <haojian.zhuang@linaro.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 "arm@kernel.org" <arm@kernel.org>, Daode Huang <huangdaode@hisilicon.com>,
 "Chenxin \(Charles\)" <charles.chenxin@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 Zhangyi ac <zhangyi.ac@huawei.com>, jinying@hisilicon.com,
 Arnd Bergmann <arnd@arndb.de>, John Garry <john.garry@huawei.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Salil Mehta <salil.mehta@huawei.com>, Guodong Xu <guodong.xu@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Leo Yan <leo.yan@linaro.org>, "Liguozhu
 \(Kenneth\)" <liguozhu@hisilicon.com>, Shiju Jose <shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Olof,

On 2018/11/30 23:46, Olof Johansson wrote:
> On Thu, Nov 29, 2018 at 03:51:49PM +0000, Wei Xu wrote:
>> Hi ARM-SoC team,
>>
>> Please consider to pull the following changes.
>> Thanks!
>>
>> Best Regards,
>> Wei
>>
>> ---
>>
>> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
>>
>>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/hisilicon/linux-hisi.git tags/hisi-arm64-dt-for-4.21
>>
>> for you to fetch changes up to 6ad5506ed191eefec7d205245edabb8b5f7e950f:
>>
>>   ARM64: dts: hisilicon: Add all CPUs in cooling maps (2018-11-29 10:11:21 +0000)
>>
>> ----------------------------------------------------------------
>> ARM64: DT: Hisilicon SoCs DT updates for 4.21
>>
>> * Hi3660 SoC and related boards:
>>   - Standardize LED labels and triggers for the hikey960 board
>>   - Add the missing cooling-cells property for the cpu nodes
>>   - Add all cpus into the cooling maps
>>
>> * Hi3670 SoC and related boards:
>>   - Add clock nodes and update the uart clock
>>   - Add Pinctrl, GPIO and uart nodes
>>   - Enable uart and add GPIO line names for the hikey970 board
>>
>> * Hi3798 SoC and related boards:
>>   - Standardize LED labels and triggers for the poplar board
>>
>> * Hi6220 SoC and related boards:
>>   - Standardize LED labels and triggers for the hikey board
>>   - Add all cpus into the cooling maps
> 
> Merged, thanks.

Thanks!

> 
>> ----------------------------------------------------------------
>> Manivannan Sadhasivam (10):
>>       arm64: dts: hisilicon: Add clock nodes for Hi3670 SoC
>>       arm64: dts: hisilicon: Source SoC clock for UART6
>>       arm64: dts: hisilicon: Add Pinctrl support for HiKey970 board
>>       arm64: dts: hisilicon: hi3670: Add GPIO controller support
>>       arm64: dts: hisilicon: hi3670: Add UART nodes
>>       arm64: dts: hisilicon: hikey970: Enable on-board UARTs
>>       arm64: dts: hisilicon: hikey970: Add GPIO line names
>>       arm64: dts: hisilicon: hikey: Standardize LED labels and triggers
>>       arm64: dts: hisilicon: hikey960: Standardize LED labels and triggers
>>       arm64: dts: hisilicon: poplar: Standardize LED labels and triggers
>>
>> Viresh Kumar (2):
>>       arm64: dts: hi3660: Add missing cooling device properties for CPUs
>>       ARM64: dts: hisilicon: Add all CPUs in cooling maps
> 
> Nit: Please use the common arm64: and ARM: patch prefixes.
> 

Got it.
Sorry for the inconsistent.
Thanks!

Best Regards,
Wei

> 
> Thanks,
> 
> -Olof
> 
> .
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
