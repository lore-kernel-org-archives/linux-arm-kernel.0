From: sricharan@codeaurora.org (Sricharan R)
Date: Fri, 16 Mar 2018 18:15:24 +0530
Subject: [PATCH v2 09/13] ARM: dts: ipq4019: Add qcom-ipq4019-ap.dk07.1-c1
 board file
In-Reply-To: <e09ea99753ce59e4b595ba3ecab36c8a@codeaurora.org>
References: <1521193101-4586-1-git-send-email-sricharan@codeaurora.org>
 <1521193101-4586-10-git-send-email-sricharan@codeaurora.org>
 <e09ea99753ce59e4b595ba3ecab36c8a@codeaurora.org>
Message-ID: <0a80b9b3-5e64-91b9-b5de-4aff09d5699a@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 3/16/2018 3:55 PM, Abhishek Sahu wrote:
> On 2018-03-16 15:08, Sricharan R wrote:
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>> ?arch/arm/boot/dts/Makefile????????????????????? |? 1 +
>> ?arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts | 65 +++++++++++++++++++++++++
>> ?2 files changed, 66 insertions(+)
>> ?create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index b71487a..8c93fd0 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -749,6 +749,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>> ???? qcom-ipq4019-ap.dk01.1-c1.dtb \
>> ???? qcom-ipq4019-ap.dk04.1-c1.dtb \
>> ???? qcom-ipq4019-ap.dk04.1-c3.dtb \
>> +??? qcom-ipq4019-ap.dk07.1-c1.dtb \
>> ???? qcom-ipq8064-ap148.dtb \
>> ???? qcom-msm8660-surf.dtb \
>> ???? qcom-msm8960-cdp.dtb \
>> diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts
>> b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts
>> new file mode 100644
>> index 0000000..4562f7f
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts
>> @@ -0,0 +1,65 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> +
>> +#include "qcom-ipq4019-ap.dk07.1.dtsi"
>> +
>> +/ {
>> +??? model = "Qualcomm Technologies, Inc. IPQ40xx/AP-DK07.1-C1";
> 
> ?s/IPQ40xx/IPQ4019
> 
> ?with that.
> 
> ?Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
  Thanks, will update

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
