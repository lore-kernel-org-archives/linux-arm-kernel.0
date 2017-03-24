From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 24 Mar 2017 16:01:37 +0800
Subject: [linux-sunxi] Re: [RESEND PATCH v4 2/9] iio: adc: add support for
 X-Powers AXP20X and AXP22X PMICs ADCs
In-Reply-To: <13f2f8ba-af9e-576e-24ee-60c3a1609f80@free-electrons.com>
References: <20170320081653.8884-1-quentin.schulz@free-electrons.com>
 <20170320081653.8884-3-quentin.schulz@free-electrons.com>
 <CAGb2v66JC65=9WiMy-Nu+9tTFRLsJL2Eyb0wfJV_K=65ABc6Zg@mail.gmail.com>
 <20170323093527.ojcdpvruzqnhvysq@earth>
 <CAGb2v655AfEavMqVV-XTyYzHWt5qFsMnoMsTVd8HRDkCgjiTeQ@mail.gmail.com>
 <13f2f8ba-af9e-576e-24ee-60c3a1609f80@free-electrons.com>
Message-ID: <CAGb2v65whWFfHFi9BULqvh8to8BbQCub_phOS3wpFVNWuPER0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 24, 2017 at 3:55 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> Hi,
>
> On 23/03/2017 10:52, Chen-Yu Tsai wrote:
>> On Thu, Mar 23, 2017 at 5:35 PM, Sebastian Reichel <sre@kernel.org> wrote:
>>> Hi,
>>>
>>> On Wed, Mar 22, 2017 at 12:34:45PM +0800, Chen-Yu Tsai wrote:
>>>> P.S. I'm thinking about having MFD_AXP20X imply its various sub-drivers.
>>>> Not sure if that was the intended usage of the new imply syntax though.
>>>
>>> I think adding "default MFD_AXP20X" to the sub-drivers is cleaner,
>>> as you will not end up with a long list.
>>
>> I'd still need to add imply statements for the various subsystems though,
>> like regulators, power supplies, extcon, etc..
>> But I suppose that's cleaner, and fits the original intent of the syntax.
>>
>
> Hum. I don't really understand what you are saying.. Am I supposed to
> modify something or, is it okay and we're waiting for Lee to apply on
> his tree?
>
> Thanks in advance for clearing it up,
>
> Quentin

I'm just mentioning some follow up tasks I want to do.
The patch is fine and we're waiting for Lee to take it.

ChenYu
