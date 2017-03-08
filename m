From: Joao.Pinto@synopsys.com (Joao Pinto)
Date: Wed, 8 Mar 2017 11:37:36 +0000
Subject: [PATCH v2 08/22] PCI: dwc: designware: Add EP mode support
In-Reply-To: <58BFEC7D.3090608@ti.com>
References: <1487325042-28227-1-git-send-email-kishon@ti.com>
 <1487325042-28227-9-git-send-email-kishon@ti.com>
 <45e5288e-d11f-c855-af9b-692a42d878c6@synopsys.com> <58BE42B2.20305@ti.com>
 <02461be2-268d-485a-2bc4-3b148726d37d@synopsys.com>
 <aa9835a7-07f4-d042-d04a-b0d9cc0ea3de@synopsys.com> <58BFEC7D.3090608@ti.com>
Message-ID: <35d539ba-956f-330e-c28d-b67c3d414578@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?s 11:35 AM de 3/8/2017, Kishon Vijay Abraham I escreveu:
> Hi,
> 
> On Wednesday 08 March 2017 05:02 PM, Joao Pinto wrote:
>>
>> Hi Kishon,
>>
>>>> Can you provide PCIE_GET_ATU_INB_UNR_REG_OFFSET (similar to
>>>> PCIE_GET_ATU_OUTB_UNR_REG_OFFSET)?
>>>
>>> Yes of course, I will send you the definition soon.
>>
>> As promissed here is the definition for Inbound:
>>
>> +/* register address builder */
>> +#define PCIE_GET_ATU_INB_UNR_REG_ADDR(region, register)		\
>> +					((0x3 << 20) | (region << 9) |	\
>> +					(0x1 << 8) | (register << 2))
> 
> Cool, thanks!

No problem! If you have doubts, please let me know.

Thanks,
Joao

> 
> -Kishon
>>
>> Thanks,
>> Joao
>>
>>>
>>> Thanks,
>>> Joao
>>>
>>>>
>>>> Thanks
>>>> Kishon
>>>>
>>>
>>
