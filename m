From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 13 May 2010 16:30:39 +0900
Subject: [PATCH] ARM: Add support for 10 hardirq bits
In-Reply-To: <20100501094436.GC12172@n2100.arm.linux.org.uk>
References: <20100310111749.18521.9002.sendpatchset@t400s>
	<u2yaec7e5c31004292102rd561d7detc73e9fd2a5570ab0@mail.gmail.com>
	<20100501094436.GC12172@n2100.arm.linux.org.uk>
Message-ID: <AANLkTil63uNv-S3D4ECYwT500w9sZd_8TE_T-SX0cqxv@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 1, 2010 at 6:44 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Apr 30, 2010 at 01:02:04PM +0900, Magnus Damm wrote:
>> On Wed, Mar 10, 2010 at 8:17 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> > From: Magnus Damm <damm@opensource.se>
>> >
>> > This patch adds support for 10 hardirq bits to
>> > the ARM architecture. Needed by the SH-Mobile
>> > ARM processor sh7372 that has more than 512 IRQs.
>> >
>> > Signed-off-by: Magnus Damm <damm@opensource.se>
>> > ---
>> >
>
> I guess it's ok; with 10 bits we're at the maximum which the generic
> kernel supports (see linux/hardirq.h)

Hi again Russell,

Will you pick up this one in your tree as-is, or would you like me to
resubmit it somehow?

Perhaps you prefer that we take it with the other changes through the
genesis-2.6 tree?

Sorry to bother you if this has already been sorted. I just noticed
that the patch isn't part of the latest linux-next.

Thanks,

/ magnus
