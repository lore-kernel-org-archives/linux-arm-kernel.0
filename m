From: jacek.anaszewski@gmail.com (Jacek Anaszewski)
Date: Tue, 28 Jul 2015 13:34:51 +0200
Subject: [PATCH v2 2/4] ARM: Kirkwood: add modes-map property to ns2-leds
 nodes
In-Reply-To: <55B75A2E.4080803@free-electrons.com>
References: <1435859803-19583-1-git-send-email-simon.guinot@sequanux.org>
 <1435859803-19583-3-git-send-email-simon.guinot@sequanux.org>
 <55B3A047.70905@free-electrons.com> <55B75A2E.4080803@free-electrons.com>
Message-ID: <55B768DB.3040409@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 28.07.2015 12:32, Gregory CLEMENT wrote:
> Hi Simon, Jacek,
>
> On 25/07/2015 16:42, Gregory CLEMENT wrote:
>> Hi Simon, Jacek, Bryan, Richard,
>>
>> On 02/07/2015 19:56, Simon Guinot wrote:
>>> From: Vincent Donnefort <vdonnefort@gmail.com>
>>>
>>> Since the LED modes mapping is no longer hardcoded inside the leds-ns2
>>> driver, then it must be provided through the modes-map property in the
>>> ns2-leds nodes.
>>>
>>> Signed-off-by: Vincent Donnefort <vdonnefort@gmail.com>
>>
>> As the other patch of the series seem to be merged in the led branch,
>> then I can apply this patch on mvebu/dt.
>>
>> It is OK for being in linux-next, however this patch depend on "leds:
>> leds-ns2: move LED modes mapping outside of the driver", so I will need
>> to find a way to express this dependency when I will do the pull request
>> to arm-soc.
>>
>
> Eventually I removed this patch from my branch.
> Jacek, you can take it with my
>
> Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>

OK, I'll take it with your ack.

-- 
Best Regards,
Jacek Anaszewski
