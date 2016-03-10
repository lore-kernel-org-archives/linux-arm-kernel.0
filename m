From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 11 Mar 2016 00:49:20 +0300
Subject: ARMv4 (not v4t) marked obsolete in gcc-6
In-Reply-To: <201603101738.55060.arnd@arndb.de>
References: <201603101013.04618.arnd@arndb.de>
 <CALT56yPDXkOvwQHngFsLkjgkyGx5HRNj8oddhFjTRdMbv5zvbw@mail.gmail.com>
 <201603101738.55060.arnd@arndb.de>
Message-ID: <CALT56yNRYP3SmmHP_j974PwW+CpnhrTGghLJ1J9WfcEx4DJgSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-03-10 19:38 GMT+03:00 Arnd Bergmann <arnd@arndb.de>:
> On Thursday 10 March 2016, Dmitry Eremin-Solenikov wrote:
>> 2016-03-10 12:13 GMT+03:00 Arnd Bergmann <arnd@arndb.de>:
>> > I've found out that ARMv3 and ARMv4 is now on track to get removed from gcc in the future,
>> > so I'm trying to alert everyone that I have knowledge of using ARMv4 based platforms that
>> > we currenly support in the Linux kernel.
>> >
>> > The architecture has been declared obsolete here: https://gcc.gnu.org/gcc-6/changes.html
>> > and it will be removed in the following release (gcc-7) one year later, unless someone
>> > raises concerns over it.
>>
>> In which form should we raise concerns? Is it about stepping up as a
>> maintainers, or just
>> about telling them that platforms are used?
>
>
> As I understand it, having someone step up as an active maintainer would leave the
> architecture supported indefinitely, while saying you still need the support
> can at least delay the process a bit. Ramana can probably clarify further
> what the gcc folks are looking for exactly.

It would be good to know exactly.

> How long do you think you need for your systems?
> Do you still ship new products, or are these all legacy devices that
> will have a failing battery or flash at some point in the future?

I'm using several old PDAs with StrongARM CPU. They have CF cards
and battery life isn't that important for me. I really see no point in dropping
support for them just because GCC folks told us so.

And BTW: I'm using EABI with that v4bx trick both in kernel and userspace.

-- 
With best wishes
Dmitry
