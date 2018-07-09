From: mathieu.desnoyers@efficios.com (Mathieu Desnoyers)
Date: Mon, 9 Jul 2018 13:17:54 -0400 (EDT)
Subject: [PATCH v2 0/3] Support rseq on arm64
In-Reply-To: <20180709165307.GB4689@arm.com>
References: <1531145985-3747-1-git-send-email-will.deacon@arm.com>
 <1957291037.1983.1531152382750.JavaMail.zimbra@efficios.com>
 <20180709165307.GB4689@arm.com>
Message-ID: <1187011512.2158.1531156674389.JavaMail.zimbra@efficios.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

----- On Jul 9, 2018, at 12:53 PM, Will Deacon will.deacon at arm.com wrote:

> On Mon, Jul 09, 2018 at 12:06:22PM -0400, Mathieu Desnoyers wrote:
>> ----- On Jul 9, 2018, at 10:19 AM, Will Deacon will.deacon at arm.com wrote:
>> 
>> > Hello,
>> > 
>> > This is version two of the patches previously posted here:
>> > 
>> > http://lkml.kernel.org/r/1529949285-11013-1-git-send-email-will.deacon at arm.com
>> > 
>> > Changes since v1 include:
>> > 
>> >  * Move abort handler in-line to avoid possibility of it being
>> >    out-of-range for conditional branch instructions
>> > 
>> > I've tested both native and compat (little-endian only) with the selftests
>> > and they pass successfully on my Seattle box.
>> 
>> For the whole series:
>> 
>> Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> Thanks, Mathieu! Are you ok with me taking this via the arm64 tree for
> 4.19 once I have an Ack for the asm-generic change, or would you rather
> this went via somewhere else?

Adding Thomas Gleixner in CC. He has been picking up the rseq bits for
4.18. I've noticed it was rather easier to gather rseq stuff through a
single tree (less chances of confusion).

Also, support for additional architectures (e.g. MIPS) was added to rseq
after rc1. Is it too late to merge arm64 support targeting 4.18 ?

Thanks,

Mathieu

> 
> Cheers,
> 
> Will

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
