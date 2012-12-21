From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 21 Dec 2012 13:52:02 +0100
Subject: [PATCH] ARM: OMAP2+: omap_twl: Change TWL4030_MODULE_PM_RECEIVER
 to TWL_MODULE_PM_RECEIVER
In-Reply-To: <20121214171800.GO4989@atomide.com>
References: <1352799152-20980-1-git-send-email-peter.ujfalusi@ti.com>
 <50A4A376.3020703@ti.com> <20121121215234.GB5279@atomide.com>
 <50ADFDD3.1080508@ti.com> <20121214171800.GO4989@atomide.com>
Message-ID: <50D45B72.2050300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On 12/14/2012 06:18 PM, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [121122 02:28]:
>> Hi Tony,
>>
>> On 11/21/2012 10:52 PM, Tony Lindgren wrote:
>>> * Peter Ujfalusi <peter.ujfalusi@ti.com> [121115 00:12]:
>>>> Hi Tony,
>>>>
>>>> On 11/13/2012 10:32 AM, Peter Ujfalusi wrote:
>>>>> To facilitate upcoming cleanup in twl stack.
>>>>> No functional change.
>>>>
>>>> Would you please consider this patch for 3.8? It would shorten the time I'll
>>>> need to progress on the cleanup regarding to twl-core greatly.
>>>
>>> Please go ahead and merge this with your other patches:
>>>
>>> Acked-by: Tony Lindgren <tony@atomide.com>
>>>
>>> Or let me know if I still need to queue it.
>>
>> This patch has no dependencies on other patches. It is better to go via
>> linux-omap.
> 
> Applying into omap-for-v3.8/fixes-for-merge-window.

Today I looked at:
omap-for-v3.8/fixes-for-merge-window-part2
omap-for-v3.8/fixes-for-merge-window-v4
omap-for-v3.8/fixes-non-critical-v2

branches as well linux-next, mainline, but I can not find this patch. I want
to send the second part of the twl-core cleanup series which needs this patch
to be in first.
Can you make sure this is going for 3.8?

Thank you,
P?ter
