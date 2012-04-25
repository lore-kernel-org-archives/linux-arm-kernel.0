From: b32955@freescale.com (Huang Shijie)
Date: Wed, 25 Apr 2012 14:51:30 +0800
Subject: [PATCH v2 0/3] add gpmi-nand dt support for mx6q and mx28
In-Reply-To: <4F979C91.9020607@de.bosch.com>
References: <1335323184-11233-1-git-send-email-b32955@freescale.com>
 <4F979C91.9020607@de.bosch.com>
Message-ID: <4F979EF2.8050904@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?04?25? 14:41, Dirk Behme ??:
> Hi Huang Shijie,
>
> On 25.04.2012 05:06, Huang Shijie wrote:
>> The mx6q-arm2 and imx28evk have already support the device tree now.
>> So i decide to add the gpmi-nand dt support to them.
>>
>> The mx23 does not support the device tree now. I will add the gpmi dt 
>> support
>> when it is ready.
>>
>> Test this patch set on both MX6Q(arm2) and mx28(evk).
>>
>> v1 --> v2
>> [1] merge the gpmi/bch device node into one node.
>> [2] add partitions support.
>> [3] misc
>>
>> Huang Shijie (3):
>> mtd: gpmi: add device tree support for mx6q and mx28
>> ARM: mx28: add gpmi-nand dt support
>> ARM: mx6q: add gpmi-nand dt support
>
> For which kernel are these 3 patches? I tried to apply them on top of 
> 3.4-rc4 and got a lot of rejects.
>
They are based on 3.4-rc4. but I also applied some mxs-dma patches.

Which one cause the rejects?
I think the first patch "mtd:gpmi .." will not meet any rejects.
The other two small patches may meet rejects, but you can fix it by hand.

BR
Huang Shijie
