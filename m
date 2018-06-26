From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Tue, 26 Jun 2018 14:17:13 -0700
Subject: [linux-next PATCH 0/4] Enable network driver on K2G ICE and GP
 EVMs
In-Reply-To: <8e1aa492-ae7a-de2b-f5d2-8756b10ece79@oracle.com>
References: <1526066952-5230-1-git-send-email-m-karicheri2@ti.com>
 <8e1aa492-ae7a-de2b-f5d2-8756b10ece79@oracle.com>
Message-ID: <3fd86a06-6702-8e1c-54e6-01b23f9fd4cd@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 5/20/2018 8:17 PM, santosh.shilimkar at oracle.com wrote:
> On 5/11/18 12:29 PM, Murali Karicheri wrote:
>> Now that NetCP driver patches for K2G SoC is merged to linux-next master
>> this series add patches to enable network driver on K2G ICE and GP EVMs.
>>
>> Thanks
>>
>> Applied the patches on top of latest linux-next master, built kernel and
>> booted up on both EVMs. The logs are below
>>
>> K2G GP EVM: https://pastebin.ubuntu.com/p/ycZDnZXYPx/
>> K2G ICE EVM: https://pastebin.ubuntu.com/p/bdCpzgdrXr/
>>
>> Murali Karicheri (4):
>> ?? ARM: dts: k2g: add dt bindings to support network driver
>> ?? ARM: dts: keystone-k2g-evm: Enable netcp network driver
>> ?? ARM: dts: keystone-k2g-ice: Enable netcp network driver
>> ?? ARM: keystone: k2g: enable micrel and dp83867 phys
>>
[...]

>>
> Looks good. Will add this to the queue for 4.19. Thanks !!
> 
Applied. You should see it in linux-next as well.

Regards,
Santosh
