From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Mon, 4 Dec 2017 09:36:25 -0800
Subject: [PATCH 6/6] ARM: configs: keystone_defconfig: Enable few
 peripheral drivers
In-Reply-To: <76a88f69-dd0b-8823-ae31-bd39b1abae87@ti.com>
References: <20171123075154.3938-1-vigneshr@ti.com>
 <20171123075154.3938-7-vigneshr@ti.com>
 <fb0c662b-d462-c663-7cf0-443ace3565ba@oracle.com>
 <76a88f69-dd0b-8823-ae31-bd39b1abae87@ti.com>
Message-ID: <9e96c65b-17aa-c49f-eef7-a4373241d231@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/4/2017 1:00 AM, Vignesh R wrote:
> Hi,
> 
> On Sunday 03 December 2017 09:30 AM, santosh.shilimkar at oracle.com wrote:
>> On 11/22/17 11:51 PM, Vignesh R wrote:
>>> Enable drivers for QSPI, LEDS, gpio-decoder that are present on 66AK2G
>>> EVM
>>> and 66AK2G ICE boards.
>>>
>>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>>> ---
>> Please submit a patch also to enable all these peripherals
>> in multi-v7 config. Just enable all remainder
>> options enabled in keystone config also in multi-v7.
> 
> K2 Platforms don't boot out of multi_v7_defconfig by default, because K2
> platforms require CONFIG_ARM_LPAE(which is disabled in multi-v7).
> 
> If the intention is to just have all drivers enabled in
> keystone_defconfig to be added to multi_v7, I can prepare a patch for
> that and test with local patch to enable LPAE.
> 
Yes. Please send a patch for it.

Regards,
Santosh
