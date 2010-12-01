From: cyril@ti.com (Cyril Chemparathy)
Date: Wed, 01 Dec 2010 11:48:18 -0500
Subject: Forced HW_BREAKPOINT
In-Reply-To: <004d01cb9174$c8d83ec0$5a88bc40$@deacon@arm.com>
References: <4CF58F22.6070803@ti.com>
	<004a01cb913d$c9c1e070$5d45a150$@deacon@arm.com>
	<4CF67525.2010304@ti.com>
	<004d01cb9174$c8d83ec0$5a88bc40$@deacon@arm.com>
Message-ID: <4CF67C52.4000300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 12/01/2010 11:28 AM, Will Deacon wrote:
[...]
>> Yes, this CPU has a trustzone capable v6.1 debug (DIDR reads
>> 0x15121004).  The problem I am facing is that DSCR bit 15 (monitor
>> debug-mode enable bit) cannot be set, it always reads back 0x2.  As a
>> result the hw_breakpoint code spews a WARN_ON() at boot.
> 
> That's unfortunate. Is there a hardware debugger connected, or does
> the core disallow monitor debug full-stop?
> 

This was without a debugger connected.  It is possible that I have
missed some top level debug enable in the SoC (haven't traced through
the entire logic yet).

Regards
Cyril.
