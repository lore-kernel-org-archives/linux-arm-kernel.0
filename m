From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 12 Oct 2018 12:24:37 +0200
Subject: [PATCH v9 04/11] dt: psci: Update DT bindings to support
 hierarchical PSCI states
In-Reply-To: <20181012101330.GA31003@e107155-lin>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
 <20181003143824.13059-5-ulf.hansson@linaro.org>
 <20181010150312.GA4844@e107155-lin>
 <CAPDyKFqP3wbd+5rvLcscNf1LUSZDROLqafsLq0Kyh0KziRJrZQ@mail.gmail.com>
 <20181011164126.GD28583@e107155-lin>
 <CAPDyKFq3=E=qDkozsu-MupEL_Efpdq62Z3aMWwGQWc+OdzPq8w@mail.gmail.com>
 <20181012101330.GA31003@e107155-lin>
Message-ID: <CAPDyKFq3k0o=cMyLy0YpcRtJZYpadrmwvU+zBDYRPoS+MOz+ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 October 2018 at 12:13, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On Fri, Oct 12, 2018 at 11:43:11AM +0200, Ulf Hansson wrote:
>> On 11 October 2018 at 18:41, Sudeep Holla <sudeep.holla@arm.com> wrote:
> [...]
>
>> > Yes, nearly there. Just thought good to add a note that the representation
>> > has no affinity towards any PSCI idle state mechanism(PC or OSI). So
>> > that it's never assumed or misunderstood.
>>
>> I understand your point. However, I think the following sentence still
>> makes sense (exist in the suggest change above).
>>
>> "In PSCI firmware v1.0, the OS-Initiated mode is introduced. In order
>> to use it, the hierarchical representation must be used."
>>
>> How about if I add: "For the default platform-coordinated mode, both
>> representations are viable options."
>>
> I would also add couple of things, how about this order:
>
> In PSCI firmware v1.0, the OS-Initiated mode is introduced. However the
> flattened vs hierarchical DT representation of power domains is orthogonal
> to OS-Initiated vs platform-coordinated PSCI CPU suspend modes and
> should be considered independent of each other.
>
> The hierarchical representation helps and makes it easy to implement
> OSI mode and OS implementations may choose to mandate it.
>
> For the default platform-coordinated mode, both representations are
> viable options.

This looks great! I am adding it to the next version, thanks!

Kind regards
Uffe
