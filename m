From: daniel@zonque.org (Daniel Mack)
Date: Thu, 20 Sep 2018 07:03:06 +0200
Subject: [PATCH] arm: dts: pxa3xx: provide correct clk-names property for
 nand controller node
In-Reply-To: <f3e704f5-a5ac-ea4a-65f2-9dc11a67c9f2@zonque.org>
References: <20180624174205.20648-1-daniel@zonque.org>
 <87po0emxhg.fsf@belgarion.home>
 <f3e704f5-a5ac-ea4a-65f2-9dc11a67c9f2@zonque.org>
Message-ID: <4099fb7b-5815-33ac-9131-c052631599c6@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/9/2018 6:20 PM, Daniel Mack wrote:
> On 25/6/2018 10:18 PM, Robert Jarzmik wrote:
>> Daniel Mack <daniel@zonque.org> writes:
>>
>>> The NAND driver looks for a clock named "core" and falls back to a pdev
>>> clock that has a wrong rate if not set.
>>>
>>> Signed-off-by: Daniel Mack <daniel@zonque.org>
>> Applied to pxa/dt with a small "line swap", ie. clock-names is one line below
>> "clocks" line.
> 
> This patch got applied twice in mainline, as ce4313f318de and as
> 267a113cec97. Not sure what went wrong here, but the same property npow
> occurs twice in the node, which leads to an error during dtb complication.

Ooops, sorry. Forget it, all is good. I've messed up a local branch.

Sorry for the noise. :(


Daniel
