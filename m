From: olof@lixom.net (Olof Johansson)
Date: Thu, 21 Nov 2013 10:59:41 -0800
Subject: ACPI vs DT at runtime
In-Reply-To: <20131121185408.GX16735@n2100.arm.linux.org.uk>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <20131115095717.GC1709@e106331-lin.cambridge.arm.com>
 <20131115175241.GB27174@quad.lixom.net>
 <20131119113015.GH5914@e106331-lin.cambridge.arm.com>
 <20131121162944.F087FC406A3@trevor.secretlab.ca>
 <20131121175822.GA9590@quad.lixom.net>
 <20131121185408.GX16735@n2100.arm.linux.org.uk>
Message-ID: <CAOesGMgzUSMDy99XojipfRd5OM88UhfbCYO0aoc5m-Q8Fwnddg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2013 at 10:54 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Nov 21, 2013 at 09:58:22AM -0800, Olof Johansson wrote:
>> On Thu, Nov 21, 2013 at 04:29:44PM +0000, Grant Likely wrote:
>> > We are pushing a lot of boundaries and doing things on ACPI that have
>> > never been done before. SPI, GPIOs, Clocks, Regulators, composite
>> > devices, key-value properties. All brand new territory, and the Linux
>> > world is driving a lot of it.
>>
>> This is a bit of a surprise and a significant concern.
>>
>> The whole point behind ACPI is that it's supposed to abstract away nearly
>> all of that, and _not_ expose clocks, regulators and other things to
>> the kernel. If we're going to expose it, then we might as well go all
>> the way and do it with DT.
>
> This depends what you want from ACPI, and what market ACPI is being
> targetted at.

We're talking ACPI on servers here.


-Olof
