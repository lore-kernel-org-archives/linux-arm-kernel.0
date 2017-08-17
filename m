From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 17 Aug 2017 08:29:42 -0600
Subject: [GIT PULL] arm64: dts: juno: Updates for v4.14
In-Reply-To: <9419e74d-1d1d-b8fa-75c5-5afd0d1b1072@arm.com>
References: <d33155aa-9925-1a65-ac82-d7cb5e7edd53@arm.com>
 <CAK8P3a3KX0iDGpWH-CYpwiuz1a2n07MdYC6zkZ0HUch0_xWm2g@mail.gmail.com>
 <9419e74d-1d1d-b8fa-75c5-5afd0d1b1072@arm.com>
Message-ID: <CANLsYkye1BioUutdCLAi=9-SnHY-yOzyO_b5fyor_PtXoe+Thg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 August 2017 at 03:14, Sudeep Holla <sudeep.holla@arm.com> wrote:
> (+Suzuki,Mathieu)
>
> Hi Arnd,
>
> On 16/08/17 22:46, Arnd Bergmann wrote:
>> On Mon, Aug 14, 2017 at 6:20 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>> ----------------------------------------------------------------
>>> ARMv8 Vexpress/Juno DT updates for v4.14
>>>
>>> 1. Replaces old coresight ATB programmable replicator compatible with
>>>    new and more generic one
>>>
>>> 2. Replaces incorrect usage of underscores for device node names in the
>>>    device tree with hyphen
>>
>> Pulled into next/dt64.
>>
>> Regarding the change of the compatible string for the replicator, can you
>> confirm that nothing ever used the old string?
>>
>> In doubt, it might be better to keep both strings present for
>> backward-compatibility.
>>
>
> I think Rob agreed to remove the old binding on the basis that it was
> never used. That's my understanding as per the thread[1]
>
> Suzuki/Mathieu,
>
> Please shout if my understand on this is wrong.
>

You are correct.

> --
> Regards,
> Sudeep
>
> [1] http://marc.info/?l=devicetree&m=149727844025618&w=2
