From: vigneshr@ti.com (Vignesh R)
Date: Wed, 7 Nov 2018 22:31:24 +0530
Subject: [PATCH v2 0/2] i2c-omap: Enable i2c-omap driver for AM654 SoCs
In-Reply-To: <20181028223450.GK1882@kunai>
References: <20180928052557.21663-1-vigneshr@ti.com>
 <09a6b1d4-f8f4-ea90-f361-bd3a92088430@ti.com> <20181028223450.GK1882@kunai>
Message-ID: <c664348b-bb5b-9cba-6ed5-040014515477@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 29/10/18 4:04 AM, Wolfram Sang wrote:
> On Sat, Oct 20, 2018 at 01:23:40PM +0530, Vignesh R wrote:
>>
>>
>> On 28-Sep-18 10:55 AM, Vignesh R wrote:
>>> Couple of patches to enable i2c-omap driver to be used with TI's new
>>> AM654 platforms.
>>>
>>>
>>> Vignesh R (2):
>>>   dt-bindings: i2c-omap: Add new compatible for AM654 SoCs
>>>   i2c: busses: Kconfig: Enable I2C_OMAP for ARCH_K3
>>>
>>>  Documentation/devicetree/bindings/i2c/i2c-omap.txt | 8 ++++++--
>>>  drivers/i2c/busses/Kconfig                         | 2 +-
>>>  2 files changed, 7 insertions(+), 3 deletions(-)
>>>
>>
>> Gentle ping...
> 
> Maintainer tags are missing. Tony is listed for this driver on OMAP2+.
> Is this his realm? Do we need a specific maintainer for this driver?
> 

I think this driver needs a separate entry, will send a patch adding my
name as reviewer for this driver.

-- 
Regards
Vignesh
