From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 19 Mar 2013 12:42:30 +0100
Subject: [PATCH 3/4][V2] ARM: nomadik: add dynamic irq flag to the timer
In-Reply-To: <alpine.LFD.2.02.1303081703160.22263@ionos>
References: <1362219013-18173-1-git-send-email-daniel.lezcano@linaro.org>
 <513A0109.9060801@linaro.org> <alpine.LFD.2.02.1303081703160.22263@ionos>
Message-ID: <51484F26.1010100@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2013 05:03 PM, Thomas Gleixner wrote:
> On Fri, 8 Mar 2013, Daniel Lezcano wrote:
> 
>>> Add the dynamic irq affinity feature to the timer clock device.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
>>> Acked-by: Rickard Andersson <rickard.andersson@stericsson.com>
>>> ---
>>
>> Hi Linus,
>>
>> AFAIU, you are ok with this patch, Rickard acked it and Vincent reviewed it.
>>
>> Thomas agreed to merge it into its tree as I requested because we will
>> need to wait for your tree to gain visibility to this new flag before
>> submitting this patch, which can take awhile.
>>
>> Could you please ack it if it is ok for you ?
> 
> I can provide a for-arm tree to pull as well. Either way fine with me.

Hi Thomas,

the patch 3/4 and 4/4 have been acked-by the different maintainers.

I saw you created a 'for-arm' branch (thanks), but the patches 3/4 and
4/4 aren't there. Did I missed something ?

Thanks
   -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
