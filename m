From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 21 Sep 2017 15:09:32 +0530
Subject: [PATCH V5 0/4] Add Broadcom STB USB phy driver
In-Reply-To: <4068eb4a-3982-742f-2b23-28a4b1484de2@gmail.com>
References: <1503683495-11766-1-git-send-email-alcooperx@gmail.com>
 <f4625f5e-db00-ebcc-4618-6f00247edfab@gmail.com>
 <f7bb89bf-1a09-891c-4ae5-3dc2e4b38d97@ti.com>
 <5DDF9572-B2D1-4316-B307-14749365221E@gmail.com>
 <4068eb4a-3982-742f-2b23-28a4b1484de2@gmail.com>
Message-ID: <73815a53-b07c-64f2-3648-b50e12e92958@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

On Thursday 21 September 2017 04:07 AM, Florian Fainelli wrote:
> Hi Kishon,
> 
> On 09/15/2017 04:49 PM, Florian Fainelli wrote:
>> On September 4, 2017 11:11:47 PM PDT, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>> Florian,
>>>
>>> On Saturday 02 September 2017 07:46 AM, Florian Fainelli wrote:
>>>>
>>>>
>>>> On 08/25/2017 10:51 AM, Al Cooper wrote:
>>>>> Add a new USB Phy driver for Broadcom STB SoCs. This driver
>>>>> supports Broadcom STB ARM SoCs. This driver in
>>>>> combination with the Broadcom STB ohci, ehci and xhci
>>>>> drivers will enable USB1.1, USB2.0 and USB3.0 support.
>>>>> This Phy driver also supports the Broadcom BDC gadget
>>>>> driver.
>>>>
>>>> Thanks Al! Kishon, feel free to merge everything through your tree
>>> there
>>>> should not be any conflicts with drivers/soc/bcm/brcmstb/common.c and
>>>> include/linux/soc/brcmstb/brcmstb.h.
>>>
>>> I'll start merging once 4.14 -rc1 is tagged.
>>
>> OK, does not that mean we will be missing this driver in 4.14? I suppose that's fine. Thanks!
> 
> Gentle ping, v4.14-rc1 is now out, can you let us know if this patch
> series is good with you? Thanks!

Thank you for reminding. Actually the patch series has quite a few "CHECK"
checkpatch warnings. Can that be fixed before merging it?

Thanks
Kishon
