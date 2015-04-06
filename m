From: grygorii.strashko@linaro.org (Grygorii.Strashko@linaro.org)
Date: Mon, 06 Apr 2015 19:28:12 +0300
Subject: [PATCH v3 4/5] i2c: davinci: use bus recovery infrastructure
In-Reply-To: <20150406160930.GA937@katana>
References: <1417448047-15236-1-git-send-email-grygorii.strashko@ti.com>
 <1417448047-15236-5-git-send-email-grygorii.strashko@ti.com>
 <20150318203151.GA12072@katana> <550C67D6.3080909@linaro.org>
 <20150403201846.GH2016@katana> <55228613.2060607@linaro.org>
 <20150406160930.GA937@katana>
Message-ID: <5522B41C.40107@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/2015 07:09 PM, Wolfram Sang wrote:
>
>>>> Of course,  i2c_davinci_wait_bus_not_busy() has to be fixed first
>>>> as proposed by Alexander Sverdlin here:
>>>>    https://patchwork.ozlabs.org/patch/448994/.
>>>
>>> Okay, good that you said it. So I'll give his patch series priority over
>>> this one.
>>
>>
>> Sorry, but this series already mises few merge windows and it has a lot
>> of revied-by and tested-by, so could we proceed please?
>>
>> Re-based & re-sent http://www.spinics.net/lists/arm-kernel/msg410810.html
>
> ??? Didn't you say above that Alexaders's patch is needed first?
>

Sorry for misunderstanding.

I said that if We'd like to continue and optimize more recovery path
then yes - Alexaders's patch will be needed (patch 2 from his series
[PATCH 2/3] i2c: davinci: Refactor i2c_davinci_wait_bus_not_busy(), 
which, in turn need to be rebased as the first one in his series and 
re-send). And in my opinion all such improvements could be done by 
subsequent patches.

-- 
regards,
-grygorii
