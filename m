From: b-cousson@ti.com (Benoit Cousson)
Date: Wed, 19 Jun 2013 04:52:00 -0500
Subject: [PATCH 0/3] Add pinmux DT nodes to CPSW for AM335x
In-Reply-To: <51C14772.4090701@ti.com>
References: <1370604775-21264-1-git-send-email-mugunthanvnm@ti.com>
 <51C14772.4090701@ti.com>
Message-ID: <51C17F40.8090607@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/19/2013 12:53 AM, Mugunthan V N wrote:
> On 6/7/2013 5:02 PM, Mugunthan V N wrote:
>> Add pinmux DT nodes to CPSW for the following AM335x boards
>> * AM335x Beaglebone
>> * AM335x EVM
>> * AM335x EVMsk
>> default state contains the pinmux required for active mode and
>> sleep mode contains pinmux reset values for energy saving.
>>
>> Mugunthan V N (3):
>>    ARM: dts: AM33XX: Add pinmux configuration for CPSW to beaglebone
>>    ARM: dts: AM33XX: Add pinmux configuration for CPSW to EVMsk
>>    ARM: dts: AM33XX: Add pinmux configuration for CPSW to am335x EVM
>>
>>   arch/arm/boot/dts/am335x-bone.dts  |   67 ++++++++++++++++++++++++++
>>   arch/arm/boot/dts/am335x-evm.dts   |   64 +++++++++++++++++++++++++
>>   arch/arm/boot/dts/am335x-evmsk.dts |   92
>> ++++++++++++++++++++++++++++++++++++
>>   3 files changed, 223 insertions(+)
>>
> Benoit
>
> Do you have any comments on this patch series,
> if not can you queue it for v3.11

The series looks good to me. I've just applied it.

Thanks,
Benoit
