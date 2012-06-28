From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Thu, 28 Jun 2012 20:15:48 +0530
Subject: [PATCH] ARM: OMAP2+: hwmod: Add new sysc_type3 into omap_hwmod
 required for am33xx
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA5D46A@DBDE01.ent.ti.com>
References: <1329481488-27771-1-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204271934230.10308@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EA5D46A@DBDE01.ent.ti.com>
Message-ID: <4FEC6E1C.8080203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 6/28/2012 8:10 PM, Hiremath, Vaibhav wrote:
> On Sat, Apr 28, 2012 at 07:04:38, Paul Walmsley wrote:
>> On Fri, 17 Feb 2012, Vaibhav Hiremath wrote:
>>
>>> In case of AM33xx family of devices (like cpsw) have different sysc
>>> bit field offsets defined,
>>>
>>> sysc_type3:
>>> |  3     2  |  1    0  |
>>> | STDBYMODE | IDLEMODE |
>>>
>>> So introduce new sysc_type3 in omap_hwmod common data.
>>>
>>> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
>>> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
>>
>> Thanks, queued for 3.5.
>>
> 
> We missed this patch last time, can you pleas make sure to include it this 
> time.
> 

Another patch which got missed from your last pull-request is,

ARM: OMAP3/4: omap_hwmod:Add rstst_off field to struct omap_hwmod_omap4_prcm


Can you please add it to your pull request?

Thanks,
Vaibhav
