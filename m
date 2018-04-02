From: sricharan@codeaurora.org (Sricharan R)
Date: Mon, 2 Apr 2018 11:42:11 +0530
Subject: [PATCH v5 10/13] ARM: dts: ipq4019: Add qcom-ipq4019-ap.dk07.1-c2
 board file
In-Reply-To: <20180327172917.GM1403@tuxbook-pro>
References: <1521800336-19266-1-git-send-email-sricharan@codeaurora.org>
 <1521800336-19266-11-git-send-email-sricharan@codeaurora.org>
 <20180327172917.GM1403@tuxbook-pro>
Message-ID: <a0bf3ee8-10f5-7384-8f87-bec3649040b4@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On 3/27/2018 10:59 PM, Bjorn Andersson wrote:
> On Fri 23 Mar 03:18 PDT 2018, Sricharan R wrote:
> 
>> Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  arch/arm/boot/dts/Makefile                      |  1 +
>>  arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts | 26 +++++++++++++++++++++++++
>>  2 files changed, 27 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index ae7f214..3b65e30 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -750,6 +750,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>>  	qcom-ipq4019-ap.dk04.1-c1.dtb \
>>  	qcom-ipq4019-ap.dk04.1-c3.dtb \
>>  	qcom-ipq4019-ap.dk07.1-c1.dtb \
>> +	qcom-ipq4019-ap.dk07.1-c2.dtb \
>>  	qcom-ipq8064-ap148.dtb \
>>  	qcom-msm8660-surf.dtb \
>>  	qcom-msm8960-cdp.dtb \
>> diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts
>> new file mode 100644
>> index 0000000..c1e909c
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts
>> @@ -0,0 +1,26 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> +
>> +#include "qcom-ipq4019-ap.dk07.1.dtsi"
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK07.1-C2";
> 
> compatible
> 

 ok.

> Apart from that you have my
> 
> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 

 Thanks.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
