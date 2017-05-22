From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Sun, 21 May 2017 22:51:30 -0700
Subject: [PATCH v2 0/4] ARM: dts: keystone: Add support for new K2G evm
In-Reply-To: <6e039dc0-7054-66a9-5cee-ce00e0898882@oracle.com>
References: <20170424202204.24170-1-fcooper@ti.com>
 <6e039dc0-7054-66a9-5cee-ce00e0898882@oracle.com>
Message-ID: <47f78dd7-de70-0eb6-181b-127de0638828@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/10/17 9:08 AM, Santosh Shilimkar wrote:
> On 4/24/2017 1:22 PM, Franklin S Cooper Jr wrote:
>> This patchset adds support for new K2G Industrial Communication Engine
>> evm. For now only a bare minimal dts which will allow ram boot.
>> Additional
>> peripherals will be added when base K2G SoC patches are upstreamed
>> allowing
>> peripherals to be enabled.
>>
>> Version 2 changes:
>> Make various tweaks to allow unit address to be added to memory node.
>>
>> Franklin S Cooper Jr (4):
>>   ARM: dts: keystone-k2g: Remove skeleton.dtsi
>>   ARM: dts: k2g-evm: Add unit address to memory node
>>   ARM: keystone: Create new binding for K2G ICE evm
>>   ARM: dts: keystone: Add minimum support for K2G ICE evm
>>
> Will pick this up for next merge window. Thanks !!
>
Applied to 'for_4.13/keystone_dts'. Should show up in next soon.

Regards,
Santosh
