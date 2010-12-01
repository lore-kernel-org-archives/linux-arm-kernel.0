From: cyril@ti.com (Cyril Chemparathy)
Date: Wed, 01 Dec 2010 15:14:19 -0500
Subject: Forced HW_BREAKPOINT
In-Reply-To: <004f01cb917d$c04b4910$40e1db30$@deacon@arm.com>
References: <4CF58F22.6070803@ti.com>
	<004a01cb913d$c9c1e070$5d45a150$@deacon@arm.com>
	<4CF67525.2010304@ti.com>
	<004d01cb9174$c8d83ec0$5a88bc40$@deacon@arm.com>
	<4CF67C52.4000300@ti.com>
	<004f01cb917d$c04b4910$40e1db30$@deacon@arm.com>
Message-ID: <4CF6AC9B.9060500@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 12/01/2010 12:32 PM, Will Deacon wrote:
> Cyril,
> 
>> This was without a debugger connected.  It is possible that I have
>> missed some top level debug enable in the SoC (haven't traced through
>> the entire logic yet).
> 
> Please can you try this patch?
> 
[...]
> 
> 
> This should cause the hw_breakpoint stuff to give up if monitor-mode
> cannot be enabled.

Could we also scale down the WARN_ONs in enable_monitor_mode?

Regards
Cyril.
