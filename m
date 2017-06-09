From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 9 Jun 2017 15:44:20 +0100
Subject: [PATCH v2 2/2] arm64: dts: Add Mediatek SoC MT2712 and evaluation
 board dts and Makefile
In-Reply-To: <1497016569.29586.36.camel@mtksdaap41>
References: <1496230773-22633-1-git-send-email-yt.shen@mediatek.com>
 <1496230773-22633-3-git-send-email-yt.shen@mediatek.com>
 <92e438b3-4e9c-421b-5398-5aad2541524c@gmail.com>
 <1497016569.29586.36.camel@mtksdaap41>
Message-ID: <3ac6fe47-9e56-b88a-4bab-efddc886ec76@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/17 14:56, YT Shen wrote:
> On Wed, 2017-05-31 at 14:42 +0200, Matthias Brugger wrote:

[...]

>>> +		cpu0: cpu at 0 {
>>> +			device_type = "cpu";
>>> +			compatible = "arm,cortex-a35";
>>
>> do you mean cortex-a53?
> No, the cpu is cortex-a35.
> Although I cannot find other cortex-a35 description in mainline kernel.

We usually don't keep track of individual cores if we don't need to
(errata workarounds, for example). And for the record, here's some blurb
about Cortex-A35:

https://www.arm.com/products/processors/cortex-a/cortex-a35-processor.php

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
