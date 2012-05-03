From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 3 May 2012 23:23:51 +0900
Subject: Making ARM multiplatform kernels DT-only?
In-Reply-To: <20120503141853.GC897@n2100.arm.linux.org.uk>
References: <201205031350.35476.arnd@arndb.de>
 <20120503141853.GC897@n2100.arm.linux.org.uk>
Message-ID: <CANqRtoRLmqLWfUYZRy8yuPWXybj0=RGxmYDEfuH+kqjT_009Jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 3, 2012 at 11:18 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, May 03, 2012 at 01:50:35PM +0000, Arnd Bergmann wrote:
>> My feeling is that we should just mandate DT booting for multiplatform
>> kernels, because it significantly reduces the combinatorial space
>> at compile time, avoids a lot of legacy board files that we cannot
>> test anyway, reduces the total kernel size and gives an incentive
>> for people to move forward to DT with their existing boards.
>
> On this point, I strongly object, especially as I'm one who uses the
> existing non-DT multiplatform support extensively. ?It's really not
> a problem for what you're trying to achieve.

Perhaps not so surprisingly, but I'm with Russell on this one.

I'd like our work-in-progress DT support to coexist with all non-DT platforms.

Thanks,

/ magnus
