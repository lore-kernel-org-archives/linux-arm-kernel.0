From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 05 Apr 2013 19:17:55 +0200
Subject: [PATCHv2 00/10] ARM: sunxi: Architecture cleanups and rework
In-Reply-To: <20130402183100.GM25867@quad.lixom.net>
References: <1364289198-11589-1-git-send-email-maxime.ripard@free-electrons.com>
 <51555CCF.2090005@free-electrons.com> <20130402183100.GM25867@quad.lixom.net>
Message-ID: <515F0743.4010509@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 02/04/2013 20:31, Olof Johansson a ?crit :
> On Fri, Mar 29, 2013 at 10:20:15AM +0100, Maxime Ripard wrote:
>> Hi Mike,
>>
>> Le 26/03/2013 10:13, Maxime Ripard a ?crit :
>>> Hi,
>>>
>>> This patchset is a serie of various cleanups and reworks in the sunxi
>>> architecture to prepare a clean landing for the next Allwinner SoC, the
>>> A31 (sun6i).
>>>
>>> The A31 is significantly different from the previous Allwinner SoC we
>>> supported, the A10 and A13, to no longer make the generic sunxi prefix
>>> we used in most compatible string relevant, while it should really have
>>> been sun4i in the first place.
>>>
>>> This set is also the occasion to cleanup the timer and irq code by
>>> switching to the recently introduced clocksource and irqchip
>>> infrastructures.
>>>
>>> This set depends on the UART patches I sent previously.
>>
>> I was meaning to take this branch, but some of the drivers changes in it
>> depends on the clock patches that Emilio sent and that are in clk-next.
>> Is it ok to merge clk-next into my branch?
> 
> All of of a <subsystem>-next branch is usually asking for trouble, since it'll
> cause all sorts of pain if the other maintianer is rebasing his for-next
> branch.
> 
> Best is to get those patches on just a minimal topic branch (that is still
> bisectable) that is shared between the trees.
> 
> Mike?

Mike, could you comment on that? I'd very much like to see this patches
come into 3.10.

Maxime


-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
