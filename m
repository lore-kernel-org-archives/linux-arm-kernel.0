From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Mon, 7 Aug 2017 16:31:43 -0500
Subject: [PATCH 0/3] ARM: dts: keystone-k2g: Add DCAN instances to 66AK2G
In-Reply-To: <69995971-2fe7-87f4-a46a-8ef4f729ffc5@oracle.com>
References: <20170802201822.11532-1-fcooper@ti.com>
 <69995971-2fe7-87f4-a46a-8ef4f729ffc5@oracle.com>
Message-ID: <8930852b-6995-3d41-440e-86f440b313ad@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Santosh,
On 08/04/2017 12:07 PM, Santosh Shilimkar wrote:
> Hi Franklin,
> 
> On 8/2/2017 1:18 PM, Franklin S Cooper Jr wrote:
>> Add D CAN nodes to 66AK2G based SoC dtsi.
>>
>> Franklin S Cooper Jr (2):
>>    dt-bindings: net: c_can: Update binding for clock and power-domains
>>      property
>>    ARM: configs: keystone: Enable D_CAN driver
>>
>> Lokesh Vutla (1):
>>    ARM: dts: k2g: Add DCAN nodes
>>
> Any DCAN driver dependency with these patchset ? If not, I can
> queue this up so do let me know.

There aren't any dependencies.
> 
> Regards,
> Santosh
