From: a0393675@ti.com (Keerthy)
Date: Wed, 25 May 2016 08:51:26 +0530
Subject: [PATCH 3/3] ARM: configs: keystone: Enable PINCTRL_SINGLE Config
In-Reply-To: <6325832e-24d2-43c7-09b4-a73b6549ee2c@oracle.com>
References: <1464006547-19569-1-git-send-email-j-keerthy@ti.com>
 <1464006547-19569-4-git-send-email-j-keerthy@ti.com>
 <5743CC80.4070404@ti.com> <5743D0FD.5070804@ti.com>
 <6325832e-24d2-43c7-09b4-a73b6549ee2c@oracle.com>
Message-ID: <57451A36.8050809@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

On Tuesday 24 May 2016 09:59 PM, Santosh Shilimkar wrote:
> Hi Keerthy,
>
> On 5/23/2016 8:56 PM, Keerthy wrote:
>>
>>
>> On Tuesday 24 May 2016 09:07 AM, Lokesh Vutla wrote:
>>>
>>>
>>> On Monday 23 May 2016 05:59 PM, Keerthy wrote:
>>>> keystone-k2l devices use pinmux and are compliant with PINCTRL_SINGLE.
>>>> Hence enable the config option.
>>>>
>>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>>
>>> A similar patch[1] is already posted.
>>>
>>> [1]https://patchwork.kernel.org/patch/8958091/
>>
>> Ah I had not seen them. If they are already reviewed and closer to be
>> merged then Patch 2 and Patch 3 of this series can be dropped.
>>
> Once the 4.7-rc2 is out, please rebase these floating patches
> against it and post a consolidated patches. I will line them
> up for 4.8

Thanks for the quick response. I will wait for 4.7-rc2 and send the 
re-based series.

Regards,
Keerthy

>
> Regards,
> Santosh
