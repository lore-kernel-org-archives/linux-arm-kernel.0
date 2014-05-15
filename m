From: alex.shi@linaro.org (Alex Shi)
Date: Thu, 15 May 2014 21:26:20 +0800
Subject: RCU stall on panda
In-Reply-To: <53748371.5030704@linaro.org>
References: <53675C5F.10509@linaro.org>
 <20140505180617.GM8754@linux.vnet.ibm.com>
 <20140512212102.GF5668@atomide.com> <5371BD69.8010600@linaro.org>
 <20140513153220.GC16837@atomide.com> <53747E6D.60500@linaro.org>
 <53748371.5030704@linaro.org>
Message-ID: <5374C07C.1070400@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/2014 05:05 PM, Daniel Lezcano wrote:
>>>
>>
>> After enable this patch, system maybe hang in idle. :(
> 
> Hi Alex,
> 
> do you mean even with this revert applied, the board hangs in idle ?
> 

yes.
My board is panda ES. without this revert, it works.

-- 
Thanks
    Alex
