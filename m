From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 6 Jun 2017 20:18:09 +0200
Subject: [PATCH v2] clockevents/tcb_clksrc: implement suspend/resume
In-Reply-To: <20170606180957.zjwjcmynzcqfqfgu@piout.net>
References: <20170512182251.23948-1-alexandre.belloni@free-electrons.com>
 <20170606164817.GF2345@mai> <20170606180957.zjwjcmynzcqfqfgu@piout.net>
Message-ID: <e8d3209d-adf6-5d23-8edb-6e070ef40831@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2017 20:09, Alexandre Belloni wrote:
> On 06/06/2017 at 18:48:17 +0200, Daniel Lezcano wrote:
>> On Fri, May 12, 2017 at 08:22:51PM +0200, Alexandre Belloni wrote:
>>> On sama5d2, power to the core may be cut while entering suspend mode. It is
>>> necessary to save and restore the TCB registers.
>>>
>>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>>> ---
>>> Changes in v2:
>>>  - use writel instead of __raw_writel
>>>  - Document sequence
>>>  - use ARRAY_SIZE(tcb_cache) instead of 3
>>>
>>>  drivers/clocksource/tcb_clksrc.c | 51 ++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 51 insertions(+)
>>>
>>> diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
>>
>> Hi,
>>
>> what should I do with this patch as the patched file is supposed to be removed
>> [1]. 
>>
> 
> I feel like we are far from reaching an agreement on the other series so
> it is still worth applying.

Ok.


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
