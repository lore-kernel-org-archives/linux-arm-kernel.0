From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 23 Dec 2011 12:07:19 +0530
Subject: [PATCH v2 07/15] ARM: local timers: switch omap4 to standalone
 smp_twd
In-Reply-To: <1324574865-5367-8-git-send-email-marc.zyngier@arm.com>
References: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
 <1324574865-5367-8-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAMQu2gz2F+oQ5Ag_8bZAPCt5cfnsZJ20nzMf9ATp2bzvZrwNPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,
On Thu, Dec 22, 2011 at 10:57 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Convert the OMAP4 platforms to the standalone version
> of smp_twd.c. Since the timer calibration code requires another
> timer to be up and running, the actual initialisation is left
> to the late_timer_init hook.
>
> Tested on a Pandaboard.
>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

IIRC, have reviewed this earlier. Looking at the patch the changes are almost
same. So for OMAP changes
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
