From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 10 Dec 2015 17:30:29 +0000
Subject: [PATCH 0/4] ARM Versatile multi-platform support
In-Reply-To: <CAL_JsqJXDAopCPLDx=6BAVfZdkwX+VihNKoL5Grs9amJe-HUGA@mail.gmail.com>
References: <1449607458-16850-1-git-send-email-robh@kernel.org>
 <CAFEAcA9Wkk+tAyrxuiLMOjQA2Y44qFGF+aXzhj7a9k6qnYobfQ@mail.gmail.com>
 <5669AF71.4080806@arm.com>
 <CAL_JsqJXDAopCPLDx=6BAVfZdkwX+VihNKoL5Grs9amJe-HUGA@mail.gmail.com>
Message-ID: <5669B6B5.9030101@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/15 17:23, Rob Herring wrote:
> On Thu, Dec 10, 2015 at 10:59 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On 08/12/15 21:11, Peter Maydell wrote:
>>> On 8 December 2015 at 20:44, Rob Herring <robh@kernel.org> wrote:
>>>> Arnd lit a fire under me to dust this off and get it merged. So here it
>>>> is. The main change from prior version is I merged all the code to a
>>>> single file. It's a bigger patch than I'd like, but I don't think trying
>>>> to do it in multiple steps is worth it.
>>>>
>>>> This is dependent on some solution for the default platform choice on
>>>> !MMU builds (allnoconfig) as it can't be Versatile after this series.
>>>> Arnd has some ideas on how to address that.
>>>>
>>>> This is tested under QEMU. Linus previously tested this on actual h/w
>>>> and had a problem with the display identification which needs
>>>> investigation or agreement to worry about it if and when someone
>>>> actually cares.
>>>
>>> I handed my PB hardware and its PCI backplane back to Will
>>> and Marc some time back, so they're in the best position to
>>> do testing of the PCI part on real hardware if needed these days.
>>
>> I don't really have the bandwidth to test that stuff right now, but I
>> recently managed to score a few PCI backplanes (backplane only, without
>> the massive case, so an ATX power supply is required to make use of it).
>> Some documentation is available at [1].
>>
>> I could easily be convinced to part with one of them, and even drop it
>> at a suitably located Linaro office, if that helps...
> 
> How about in a canal? That will cut the install base in half. ;)

I believe Will would object to fishing the backplane out of the canal
instead of a trout.

> We'll settle for an ack meaning "I don't have time to test, working
> for qemu is good enough, we should merge this anyway and can pick up
> the pieces later if any of the 2 or 3 people that have a system ever
> really care."

Works for me:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
