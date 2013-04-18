From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 18 Apr 2013 16:32:26 +0200
Subject: [PATCH 18/19] ARM: at91: suspend both memory controllers on
 at91sam9263
In-Reply-To: <51700105.9080802@atmel.com>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <1359153858-31992-19-git-send-email-arnd@arndb.de>
 <516FF8FC.7070901@atmel.com> <201304181615.20542.arnd@arndb.de>
 <51700105.9080802@atmel.com>
Message-ID: <517003FA.4000509@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/18/2013 04:19 PM, Nicolas Ferre wrote:
> On 04/18/2013 04:15 PM, Arnd Bergmann :
>> On Thursday 18 April 2013, Nicolas Ferre wrote:
>>
>>>> This patch blindly removes the warning and changes the
>>>> at91sam9263 to use the same code at at91sam9g45, which
>>>> may or may not be the right solution. If it is not,
>>>> maybe someone could provide a better fix.
>>>
>>> Maybe you can remove this paragraph: now you are using the proper fix
>>> with proper RAM type.
>>>
>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>>> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
>>>
>>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>>>
>>> What is the future of this patch series: do you want us to take this
>>> patch separately or to you want to apply the whole series on the arm-soc
>>> tree?
>>
>> I'd prefer if you could just apply or forward it to an appropriate tree.
>>
>> Most of the other patches have found their way into mainline by now.
>>
>>>> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
>>>> Cc: Andrew Victor <linux@maxim.org.za>
>>>> Cc: Albin Tonnerre <albin.tonnerre@free-electrons.com>
>>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>
>>> Moreover, this patch my conflict with Daniel's current initiative to
>>> move cpuidle driver to its own directory: how do we coordinate with each
>>> other?
>>
>> Maybe you can make sure it actually works and send it to Daniel to apply on
>> top of his other patches?
> 
> Well, as Daniel's patches are still under construction, I stack this one
> on the at91-3.10-soc branch and let Daniel rebase his work on top of a
> 3.10-rc1-ish tree...

No problem.

Thanks
  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
