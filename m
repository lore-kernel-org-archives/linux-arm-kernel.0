From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Oct 2017 14:11:24 +0100
Subject: [GIT PULL] ARM: at91: DT for 4.15
In-Reply-To: <20171030124647.ovlshhuusv6aov4q@piout.net>
References: <20171022195820.hxpzeunexwao26l2@piout.net>
 <CAK8P3a0ZGHFmMG5Z9Xaa2WfPMTdgN7yAAj7tGH_f__Q5LAwiWw@mail.gmail.com>
 <20171030124647.ovlshhuusv6aov4q@piout.net>
Message-ID: <CAK8P3a3+MbuqQW5uLtTqbwAdqe3zG8jzo990JH-zxzj39=W-5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 30, 2017 at 1:46 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 30/10/2017 at 13:38:04 +0100, Arnd Bergmann wrote:
>> On Sun, Oct 22, 2017 at 9:58 PM, Alexandre Belloni
>> <alexandre.belloni@free-electrons.com> wrote:
>> >
>> > Wenyou Yang (1):
>> >       ARM: dts: at91: sama5d2_xplained: Add charger node
>> >
>>
>> Can you clarify this patch? It looks like an incompatible binding change.
>>
>
> Sort of but not exactly. The DT made it to the mainline but not the
> driver (it was working with a driver in the atmel vendor tree though).
> When the driver was upstreamed, the binding changed and now we simply
> switch to the correct upstream binding.

Ok, makes sense. Thanks for the explanation, pulled the branch into next/dt now.

        Arnd
