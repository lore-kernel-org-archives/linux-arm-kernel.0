From: b-cousson@ti.com (Benoit Cousson)
Date: Mon, 5 Nov 2012 11:51:00 +0100
Subject: [PATCH V2 0/3] ARM: dts: omap5: EMIF and LPDDR2 device tree data
In-Reply-To: <50975581.7010508@ti.com>
References: <1349959669-16366-1-git-send-email-lokeshvutla@ti.com>
 <50975581.7010508@ti.com>
Message-ID: <50979A14.1050805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lokesh,

On 11/05/2012 06:58 AM, Lokesh Vutla wrote:
> Hi,
> On Thursday 11 October 2012 06:17 PM, Lokesh Vutla wrote:
>> This patch series adds Device tree data for the EMIF
>> sdram controllers in OMAP5 and LPDDR2 memory devices
>> in OMAP5-evm board.
>>
>> Testing:
>> - Boot tested on OMAP5430 evm.
>> - Built EMIF as a module.
>>
>> Changes from v1:
>> * Created a seperate dtsi file for Samsung LPDDR2 memory device
>>    used in OMAP5-evm.
>> * Passing reg and interrupt fields from dt for EMIF1 and EMIF2.
> Gentle ping on this series.

Sorry, I missed it. It might be too late for 3.8, since Tony wanted us
to push before -rc4. I'll pull the series anyway just in case.

I have a least one comment.

Regards,
Benoit

> 
> Thanks
> Lokesh
>>
>> Lokesh Vutla (3):
>>    ARM: dts: omap5-evm: Fix size of memory defined for EVM
>>    ARM: dts: omap5: EMIF device tree data for OMAP5 boards
>>    ARM: dts: omap5-evm: LPDDR2 memory device details for EVM
>>
>>   arch/arm/boot/dts/omap5-evm.dts           |   13 +++++-
>>   arch/arm/boot/dts/omap5.dtsi              |   24 +++++++++++
>>   arch/arm/boot/dts/samsung_k3pe0e000b.dtsi |   67
>> +++++++++++++++++++++++++++++
>>   3 files changed, 103 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/arm/boot/dts/samsung_k3pe0e000b.dtsi
>>
> 
