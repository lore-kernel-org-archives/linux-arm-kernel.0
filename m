From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 04 Sep 2015 09:36:36 +0200
Subject: [PATCH V2] clockevents/drivers/mtk: Fix spurious interrupt leading
 to crash
In-Reply-To: <1441350953.12270.6.camel@mtksdaap41>
References: <1440426924.17418.11.camel@mtksdaap41>		
 <1440453450-21203-1-git-send-email-daniel.lezcano@linaro.org>	
 <1440508871.29634.1.camel@mtksdaap41> <55DDCC4B.7010203@linaro.org>
 <1441350953.12270.6.camel@mtksdaap41>
Message-ID: <55E94A04.90006@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/04/2015 09:15 AM, Yingjoe Chen wrote:
> On Wed, 2015-08-26 at 16:25 +0200, Daniel Lezcano wrote:
>> On 08/25/2015 03:21 PM, Yingjoe Chen wrote:
>>> Tested-by: Yingjoe Chen<yingjoe.chen@mediatek.com>
>>
>> Applied to my tree for 4.4.
>>
>>     -- Daniel
>>
>
> Hi Daniel,
>
> I can't find this patch in
> https://git.linaro.org/people/daniel.lezcano/linux.git
> Is this tree public now? Where can I see it?
>
> Also, will you take patch[1] "clocksource: mediatek: Use GPT as sched
> clock source" in your tree?

Yep. I did not push my branch. Done.

Note it will be also available for linux-next.

Thanks for the head up.

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
