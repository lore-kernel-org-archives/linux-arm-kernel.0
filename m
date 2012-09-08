From: nico@fluxnic.net (Nicolas Pitre)
Date: Sat, 08 Sep 2012 09:59:40 -0400 (EDT)
Subject: [PATCH v3 00/31] AArch64 Linux kernel port
In-Reply-To: <504B0D6B.9010908@ti.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <504B0D6B.9010908@ti.com>
Message-ID: <alpine.LFD.2.02.1209080950170.28681@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 8 Sep 2012, Santosh Shilimkar wrote:

> Mostly I was looking at the series from SOC boot and CPU PM
> point of view and boot part seems to just fine.
> 
> As per discussion at LPC, I have gone through the SMC
> proposal which ARM has published. In general the boot part
> with SMC seems to be doable and can be standardized across SOCs.
> The part which will be conflicting is the CPU power management.
> That seems to be the harder one and the document is at too
> infancy stage from the details point of view. Some bits about
> save, restore are related to switcher kind of architecture, which
> may not be the requirement for all the SoCs.

I've reviewed an earlier draft of that document.  Although the examples 
in the latest document appear to be geared towards switcher usage, my 
suggestions to the ARM folks was to take into account the CPU hotplug 
scenario instead.  The provided examples remained switcher centric, but 
the API in the published document is now much more generic than it used 
to be.  I think it should cover all usage scenarios now.

> Ofcourse the SMC discussion is not related to $subject series
> as such. Also the PM support for ARMv8 not seems be the scope
> of the series so the discussion can be parked aside till we
> need to talk about it.

If you wish to discuss this further (maybe in a separate thread) I'll be 
glad to discuss this with you.


Nicolas
