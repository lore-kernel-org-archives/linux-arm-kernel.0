From: sricharan@codeaurora.org (sricharan at codeaurora.org)
Date: Tue, 20 Mar 2018 17:40:21 +0530
Subject: [PATCH v3 06/13] ARM: dts: ipq4019: Add ipq4019-ap.dk04.1-c1
 board file
In-Reply-To: <152153125818.254778.5435627269964796441@swboyd.mtv.corp.google.com>
References: <1521518336-5467-1-git-send-email-sricharan@codeaurora.org>
 <1521518336-5467-7-git-send-email-sricharan@codeaurora.org>
 <152153125818.254778.5435627269964796441@swboyd.mtv.corp.google.com>
Message-ID: <a8ec44084bbcf7d6b4e51f195c9d6046@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-03-20 13:04, Stephen Boyd wrote:
> Quoting Sricharan R (2018-03-19 20:58:49)
>> diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts 
>> b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
>> new file mode 100644
>> index 0000000..871ac3f
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
>> @@ -0,0 +1,20 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> +
>> +#include "qcom-ipq4019-ap.dk04.1.dtsi"
>> +
>> +/ {
>> +       model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK04.1-C1";
>> +
>> +       soc {
>> +               qpic_bam: dma at 7984000 {
> 
> Why the labels?
> 

   ok, will remove here and few other places to make it uniform.

Regards,
  Sricharan

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
