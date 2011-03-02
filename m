From: khilman@ti.com (Kevin Hilman)
Date: Wed, 02 Mar 2011 15:46:10 -0800
Subject: [PATCH 00/17] omap4: pm: suspend, hotplug and cpuilde support
In-Reply-To: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Sat, 19 Feb 2011 16:12:21 +0530")
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <87oc5txf0d.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> This series adds OMAP4 suspend and cpuidle support till MPU subsystem
> (MPUSS) off-mode. The suspend on SMP machines uses cpu-hotplug 
> infrastructure to take down the non-boot CPUs. We put secondary
> CPU(CPU1 in OMAP4) to OFF state via cpu-hotplug.
> In cpuidle too, low power states are attempted only when the
> CPU1 is put to OFF state via cpu-hotplug because of hardware
> constraints.

Minor nit on patch subjects:  both OMAP and PM are acronyms, please
capitalize.

Also, can you rebase this on Paul's integration-2.6.39 branch?  There
are several things in this series that conflict with changes there.

Thanks,

Kevin
