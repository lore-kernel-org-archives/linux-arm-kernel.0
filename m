From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 21 Jul 2014 20:15:16 +0200
Subject: [PATCH v3 4/4] arm: pxa: add non device-tree timer link to
 clocksource
In-Reply-To: <53CD25A4.7030606@linaro.org> (Daniel Lezcano's message of "Mon,
 21 Jul 2014 16:37:24 +0200")
References: <1405356724-32207-1-git-send-email-robert.jarzmik@free.fr>
 <1405356724-32207-4-git-send-email-robert.jarzmik@free.fr>
 <53CD25A4.7030606@linaro.org>
Message-ID: <87oawivarv.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> On 07/14/2014 06:52 PM, Robert Jarzmik wrote:
>> As clocksource pxa_timer was moved to clocksource framework, the
>> pxa_timer initialization needs to be a bit amended, to pass the
>> necessary informations to clocksource, ie :
>>   - the timer interrupt (mach specific)
>>   - the timer registers base (ditto)
>>   - the timer clockrate
>>
>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>>
>> ---
>> Since V2: Arnd's comment : moved extern declaration into .h file
>> ---
>
> Shall I take the patches 4-5 also ?
Mmm you mean patch 4 I think.
Then I'd like you too, because it's linked in the serie, and without it the
former non-DT platforms break, hence I'd like all the serie to go through 1
tree.

Yet we'd need Haojian's ack here. Haojian, would you give your blessing on the
serie and agree that Daniel carries all the patches including patch 4/4 ?

Cheers.

--
Robert
