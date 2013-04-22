From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 22 Apr 2013 18:54:04 +0200
Subject: [V3 patch 17/19] ARM: kirkwood: cpuidle: use init/exit common
 routine
In-Reply-To: <20130422164756.GG29947@lunn.ch>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
 <1365770165-27096-18-git-send-email-daniel.lezcano@linaro.org>
 <20130414151429.GF5061@lunn.ch> <5174E036.9090808@linaro.org>
 <20130422164756.GG29947@lunn.ch>
Message-ID: <51756B2C.3080405@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2013 06:47 PM, Andrew Lunn wrote:
> On Mon, Apr 22, 2013 at 09:01:10AM +0200, Daniel Lezcano wrote:
>> On 04/14/2013 05:14 PM, Andrew Lunn wrote:
>>
>> [ ... ]
>>>  int kirkwood_cpuidle_remove(struct platform_device *pdev)
>>>  {
>>> -	cpuidle_unregister_device(device);
>>> -	cpuidle_unregister_driver(&kirkwood_idle_driver);
>>> -
>>> +	cpuidle_unregister(&kirkwood_idle_driver);
>>>  	return 0;
>>>  }
>>>  
>>> -- 
>>> 1.7.9.5
>>>
>>> Tested-by: Andrew Lunn <andrew@lunn.ch>
>>
>> Hi Andrew,
>>
>> shall I consider it as acked-by also ?
> 
> Yes, please do.

Thanks !

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
