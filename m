From: khilman@ti.com (Kevin Hilman)
Date: Wed, 02 Mar 2011 15:44:27 -0800
Subject: [PATCH 07/17] omap4: pm: CPU1 wakeup workaround form Low power
	modes
In-Reply-To: <1298112158-28469-8-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Sat, 19 Feb 2011 16:12:28 +0530")
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
	<1298112158-28469-8-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <87tyflxf38.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> The SGI(Software Generated Interrupts) are not wakeup capable from
> low power states. This is known limitation on OMAP4 and needs to be
> worked around by using software forced clockdomain wake-up. CPU0 forces
> the CPU1 clockdomain to software force wakeup. After the wakeup, CPU1
> restores its clockdomain hardware supervised mode.
>
> More details can be found in OMAP4430 TRM - Version J
> Section :
> 	4.3.4.2 Power States of CPU0 and CPU1
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>

One other thing... 

in subject: s/form/from/

Kevin
