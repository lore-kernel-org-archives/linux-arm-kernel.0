From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 02 Apr 2015 10:37:47 +0100
Subject: [GIT PULL] Support for Fujitsu MB86S7X SoCs
In-Reply-To: <CAJe_ZheO1iNKj80798gT8RLcYoYo3xky3urw=ke4x-3wKdtZ9w@mail.gmail.com>
References: <CAKR0VNJdCEEoM8mqFrc-teQ-q=DopGisos16+uKt=ky2mRjF8g@mail.gmail.com>
 <CAJe_ZheO1iNKj80798gT8RLcYoYo3xky3urw=ke4x-3wKdtZ9w@mail.gmail.com>
Message-ID: <551D0DEB.1060609@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 31/03/15 04:02, Jassi Brar wrote:
> On 18 March 2015 at 11:14, Vincent Yang <vincent.cw.yang@gmail.com> wrote:
>> Hi Arnd and Olof,
>>
>> Please consider pulling in these patches for series of Fujitsu SoC
>> based around variations of 2xCA7+2xCA15 big.LITTLE architecture.
>>
>> The MHU driver is already queued in Mailbox tree.
>>

I see this in next but would like to fix the binding before it gets
merged in v4.1. I have provided feedback on that patch. Mainly the
compatible, clocks and the interrupt names have to fixed in the binding.
Code changes can be done later, but bindings no. I prefer an ACK from DT
guys if possible.

Regards,
Sudeep
