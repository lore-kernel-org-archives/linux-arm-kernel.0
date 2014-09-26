From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 26 Sep 2014 09:52:07 +0200
Subject: [PATCH v3 4/4] arm: pxa: add non device-tree timer link to
 clocksource
In-Reply-To: <87oawivarv.fsf@free.fr>
References: <1405356724-32207-1-git-send-email-robert.jarzmik@free.fr>	<1405356724-32207-4-git-send-email-robert.jarzmik@free.fr>	<53CD25A4.7030606@linaro.org>
 <87oawivarv.fsf@free.fr>
Message-ID: <54251B27.909@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/21/2014 08:15 PM, Robert Jarzmik wrote:
> Daniel Lezcano <daniel.lezcano@linaro.org> writes:
>
>> On 07/14/2014 06:52 PM, Robert Jarzmik wrote:
>>> As clocksource pxa_timer was moved to clocksource framework, the
>>> pxa_timer initialization needs to be a bit amended, to pass the
>>> necessary informations to clocksource, ie :
>>>    - the timer interrupt (mach specific)
>>>    - the timer registers base (ditto)
>>>    - the timer clockrate
>>>
>>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>>>
>>> ---
>>> Since V2: Arnd's comment : moved extern declaration into .h file
>>> ---
>>
>> Shall I take the patches 4-5 also ?
> Mmm you mean patch 4 I think.
> Then I'd like you too, because it's linked in the serie, and without it the
> former non-DT platforms break, hence I'd like all the serie to go through 1
> tree.
>
> Yet we'd need Haojian's ack here. Haojian, would you give your blessing on the
> serie and agree that Daniel carries all the patches including patch 4/4 ?

Hi,

May be I missed it but I don't see the Haojian's ack.

Thanks
   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
