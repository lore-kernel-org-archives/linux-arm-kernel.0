From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 5 Apr 2012 11:21:45 -0500
Subject: [PATCHv5 16/18] I2C: OMAP: fix missing handling of errata
 I2C_OMAP3_1P153
In-Reply-To: <4F7C9F5F.8010206@ti.com>
References: <1333468957-5999-1-git-send-email-shubhrajyoti@ti.com>
 <1333468957-5999-17-git-send-email-shubhrajyoti@ti.com>
 <4F7C7780.7040807@ti.com>
 <CAM=Q2cu8k8n2w8_=8VCFcFTTgywqc_Vk_eM_DDTap3YeYyAH2g@mail.gmail.com>
 <4F7C9F5F.8010206@ti.com>
Message-ID: <4F7DC699.8000609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/04/2012 02:22 PM, Jon Hunter wrote:
> Hi Shubhro,
>
> On 04/04/2012 12:45 PM, Shubhrajyoti Datta wrote:
>> Hi Jon,
>>
>>
>>>> + if (dev->flags& OMAP_I2C_FLAG_APPLY_ERRATA_I207)
>>>>
>>>> + dev->errata |= I2C_OMAP_ERRATA_I207;
>>>> +
>>>> if (dev->rev<= OMAP_I2C_REV_ON_3430_3530)
>>>> dev->errata |= I2C_OMAP3_1P153;
>>>
>>>
>>> The errata ID is not correct. I believe that 1P153 is referring to the
>>> section number in the errata doc and not the errata ID. The errata ID
>>> should
>>> be i451 in the latest OMAP34xx and OMAP36xx docs.
>>>
>>> Please can you update this? The section number changed in the latest
>>> errata
>>> docs and it took me a minute to find this.
>>
>> Do you mind if that is a separate patch?
>
> Not at all and in fact it probably should be.

Sorry the erratum ID is not i451 but i462!

Cheers
Jon
