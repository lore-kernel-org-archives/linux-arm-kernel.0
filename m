From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 4 Jan 2018 17:54:13 +0100
Subject: [PATCH v2 0/4] arm64: defconfig: enable additional led triggers
In-Reply-To: <CAP245DUnO6qoXXoAOakQ_HYTTbR+CgO-nQ-Jm5nOaPeySm968g@mail.gmail.com>
References: <cover.1509951550.git.amit.kucheria@linaro.org>
 <CAHLCerN4sYpU7PJG7JLhAy644s3jz9KD_myKWfOoOkEResPu-Q@mail.gmail.com>
 <CAK8P3a0+4ACDucmNQ3OL_0UjJnK6d3JXOb6_z5jtMQ986uZkLQ@mail.gmail.com>
 <CAP245DUnO6qoXXoAOakQ_HYTTbR+CgO-nQ-Jm5nOaPeySm968g@mail.gmail.com>
Message-ID: <CAK8P3a1OFSM3MLojnJSaRBG0BzOV9_dGPf5TEBtyTDBBp9PpZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 2, 2018 at 8:19 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> On Thu, Dec 21, 2017 at 8:46 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Wed, Dec 6, 2017 at 9:57 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
>>> (Adding Arnd)
>>>
>>> Now that the merge window rush has abated, can you please apply this
>>> trivial series?
>>>
>>> On Mon, Nov 6, 2017 at 12:38 PM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
>>>> This patchset enables the kernel panic and disk-activity trigger for LEDs
>>>> and then enables the panic trigger for three 96Boards - DB410c, Hikey and
>>>> Hikey960.
>>>>
>>>> DB410c and Hikey panic behaviour has been tested by triggering a panic
>>>> through /proc/sysrq-trigger, while Hikey960 is only compile-tested.
>>
>> I applied all four now, but it would have been easier for me if you had either
>> sent them to the platform maintainers, or to arm at kernel.org.
>
> The platform maintainers are cc'ed but I guess nobody took them since
> the patchset touched 3 different platforms and a common defconfig.
>
> I'll remember to cc arm at kernel.org in the future but is there any
> reason why this email address isn't listed in MAINTAINERS?

We normally want to have all patches merged through the platform
maintainers, and have no ambiguity regarding who picks things up.
More importantly, being listed in the MAINTAINERS file would result
in us getting thousands of patches each merge window mixed in with
the stuff that we actually do need to see, so that would likely be more
lossy and more work for us.

      Arnd
