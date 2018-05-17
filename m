From: eric@anholt.net (Eric Anholt)
Date: Thu, 17 May 2018 18:09:34 +0100
Subject: [PATCH] arm: bcm2835: Add the PMU to the devicetree.
In-Reply-To: <alpine.DEB.2.21.1805171233500.7984@macbook-air>
References: <20180517131727.29263-1-eric@anholt.net>
 <1412187220.62585.1526572780332@email.1und1.de>
 <alpine.DEB.2.21.1805171233500.7984@macbook-air>
Message-ID: <877eo2mcoh.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vince Weaver <vincent.weaver@maine.edu> writes:

> On Thu, 17 May 2018, Stefan Wahren wrote:
>
>> 
>> > Eric Anholt <eric@anholt.net> hat am 17. Mai 2018 um 15:17 geschrieben:
>> > 
>> > 
>> > The a53 and a7 counters seem to match up, so we advertise a7 so that
>> > arm32 can probe.
>
> so how closely did you look at the a53/a7 differences?  I see some major 
> differences, especially with the CPU_CYCLES event (0xff vs 0x11).

I'm a bit lost in the code, but it seemed like the 0xff was a
placeholder for a bit of special behavior, but that the cpu_cycles ->
ARMV7_PERFCTR_CLOCK_CYCLES mapping got you that same value in the end.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180517/24fefc2e/attachment-0001.sig>
