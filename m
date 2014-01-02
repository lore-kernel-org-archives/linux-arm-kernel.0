From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 02 Jan 2014 19:51:26 +0100
Subject: [PATCH 01/17] ARM: spear: Remove deprecated IRQF_DISABLED flag
In-Reply-To: <201401021929.46581.arnd@arndb.de>
References: <1388419771-30075-1-git-send-email-daniel.lezcano@linaro.org>
 <201401021929.46581.arnd@arndb.de>
Message-ID: <52C5B52E.6080609@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/2014 07:29 PM, Arnd Bergmann wrote:
> On Monday 30 December 2013, Daniel Lezcano wrote:
>> This flag is a NOOP and scheduled to be removed
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> Thanks for sending this series. I think the patches are duplicates of stuff that
> Michael Opdenacker has sent before (actually multiple times). I have no problem
> applying either version into arm-soc, but I think it would be better to attribute
> them to Michael, since he came first. Can you two please coordinate and send a
> single pull request for the arm-soc related patches that haven't made it into
> linux-next yet?

Michael removed the flag for:

pxa (ed7936f913456e4c01aed75deba6cfaf830fa8cf)
samsung (fa53d5cdbffbce421c3bd2f937b5626fc044fedc)
avr32 (7155530d9eb692994d208836e4965da06b17c99d)
ep93xx (3a71ae4796fdaedbdbdab94660b7b7b5bfe61d1d)
plat-orion (eb4d552b933ac59c0c8e0604ff435c5208a82679)

The patchset I sent is on top of arm/for-next and finishes to remove 
this flag for arch/arm. It should not overlap with what Michael did.

I'm ok to attribute the patchset to Michael if that can help to accept 
this patchset and kill this flag for arch/arm.

Thanks
   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
