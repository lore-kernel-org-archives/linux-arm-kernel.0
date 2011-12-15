From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 15 Dec 2011 10:47:48 +0000
Subject: [PATCH v4] ARM: sched_clock: allow sched_clock to be selected
 at runtime
In-Reply-To: <20111214220737.GR32251@atomide.com>
References: <1323444833-10587-1-git-send-email-marc.zyngier@arm.com>
 <4EE57BC3.4080306@gmail.com> <4EE63459.1030105@arm.com>
 <20111213004656.GR32251@atomide.com> <20111213005018.GS32251@atomide.com>
 <CAH9JG2X9dGJVdwzs2Wbqt9_8=Lg1bsrDP_A0n-JDxgN3bAOYKg@mail.gmail.com>
 <4EE7A03D.7060208@arm.com> <20111213211641.GC14542@n2100.arm.linux.org.uk>
 <20111214220737.GR32251@atomide.com>
Message-ID: <4EE9D054.9060705@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/12/11 22:07, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [111213 12:45]:
>> On Tue, Dec 13, 2011 at 06:58:05PM +0000, Marc Zyngier wrote:
>>> On 13/12/11 01:33, Kyungmin Park wrote:
>>>> Tested-by: Kyungmin Park <kyungmin,park@samsung.com>
>>>>
>>>> On 12/13/11, Tony Lindgren <tony@atomide.com> wrote:
>>>>> * Tony Lindgren <tony@atomide.com> [111212 16:46]:
>>>>>> * Marc Zyngier <marc.zyngier@arm.com> [111212 08:33]:
>>>>>>>
>>>>>>> Queued as patch 7205/1.
>>>>>>>
>>>>>>> 	M.
>>>>>>
>>>>>> Great, seems to boot fine on all omaps I tried, will go ack it
>>>>>> in the patch system.
>>>>>
>>>>> Hmm I guess you can't comment patches there, so:
>>>>>
>>>>> Tested-by: Tony Lindgren <tony@atomide.com>
>>>
>>> While I'm really glad to see platform maintainers testing and acking
>>> patches, may I kindly remind them to post their comments as early as
>>> possible?
> 
> Don't blame me on this one, there's a documented earlier Tested-by
> from me on September 2nd for v3 of this patch that Marc even thanked
> for:
> 
> http://comments.gmane.org/gmane.linux.ports.arm.kernel/130635
> 
> :P

For the record, you are usually one of the most responsive maintainers
(at least for the patches I send). But I'm not going to give good or bad
points here, that wasn't my goal at all.

I just wanted to point out that we share a collective responsibility in
reviewing patches. Unresponsive maintainers are slowing down the
improvements we make to the code as a whole, and are giving the
impression that they don't care about their platform anymore.

But enough ranting, I'm going back hacking... ;-)

	M.
-- 
Jazz is not dead. It just smells funny...
