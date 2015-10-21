From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 21 Oct 2015 13:41:13 +0100
Subject: [PATCH 10/19] ARM: dts: at91: replace gpio-key,wakeup with
 wakeup-source property
In-Reply-To: <56277372.6080203@arm.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
 <1445422216-29375-11-git-send-email-sudeep.holla@arm.com>
 <5627672D.60108@atmel.com> <56276832.9040006@arm.com>
 <CAPDyKFq8CfzVPPCz=1AxZM3wsw8pkOPG6Ua_5spDuYa=Gzshrw@mail.gmail.com>
 <56277372.6080203@arm.com>
Message-ID: <562787E9.9030606@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/10/15 12:13, Sudeep Holla wrote:
> On 21/10/15 12:01, Ulf Hansson wrote:
>> On 21 October 2015 at 12:25, Sudeep Holla <sudeep.holla@arm.com> wrote:

[..]

>>>
>>> Yes that was my intention for splitting the patches per SoC group.
>>> Many SoC maintainers prefer that.
>>
>> Hold on! All patches that changes the DT parsing to accept the
>> "standardized wakeup-source" binding, need to be merged upstream
>> before corresponding DTS changes.
>>
>
> Agreed. Sorry for that I forgot about it as there are only few
> subsystems that needed additions. Most of the input subsystem had
> already moved to new binding, just that binding documents were left
> unchanged.
>

Having looked at it again, I think at-least this patch has no dependency
on those driver/sub-system changes. Only patch 11, 13 and 17 has
dependency. All the other DTS changes are related to input subsystem
where all the required changes are already there.

-- 
Regards,
Sudeep
