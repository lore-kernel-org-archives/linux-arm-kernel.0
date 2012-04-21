From: viresh.linux@gmail.com (viresh kumar)
Date: Sat, 21 Apr 2012 17:59:27 +0530
Subject: [PATCH 0/9] Add support for SPEAr13xx SoCs
In-Reply-To: <201204211224.47826.arnd@arndb.de>
References: <cover.1334942163.git.viresh.kumar@st.com>
 <201204201821.28266.arnd@arndb.de>
 <CAOh2x=kX93nDDTfVq-ERBF=UDRZAUSwnwCuO35R+E-SZjcFUag@mail.gmail.com>
 <201204211224.47826.arnd@arndb.de>
Message-ID: <CAOh2x=kHEzJjj5iQBZ4qM5DSAv_aNBd5ke3ArFAbBuyVS_-PRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/21/12, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 21 April 2012, viresh kumar wrote:
>> On 4/20/12, Arnd Bergmann <arnd@arndb.de> wrote:
>> > I've looked at all the platform specific bits and they look pretty
>> > good,
>> > great work! I have ignored the pinctrl and clock drivers and hope that
>> > the
>> > respective maintainers will be able to judge them well.
>> >
>> > There are a few places where you still hardcode stuff that could be
>> > turned
>> > into device tree properties, but those are corner cases and you have an
>> > existing platform here that you've done a great amount of excellent
>> > cleanups
>> > to in the last weeks, so my feeling is that all the platform code can go
>> > in
>> > when you take care of the stuff that I've commented on, most of those
>> > things
>> > should be simple.
>>
>> Have fixed most of stuff you pointed to. Check V2.
>>
>
> Wow, that was fast ;-)

Actually i should say it now:

Wow, that was too fast ;-)

> Can you comment on the ones you did not address? In particular,
> I'd like to understand why you put the SPEAR1310_RAS_CTRL*
> register definitions into a globally visible header file.

I was replying to that mail only when you wrote this. Can check my
reply there.

--
viresh
