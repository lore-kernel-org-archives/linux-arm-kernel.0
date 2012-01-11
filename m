From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 11 Jan 2012 14:14:25 +0100
Subject: [PATCH 05/15] ARM: OMAP4: convert to twd_local_timer_register()
 interface
In-Reply-To: <1326287334-1905-6-git-send-email-marc.zyngier@arm.com>
References: <1326287334-1905-1-git-send-email-marc.zyngier@arm.com>
 <1326287334-1905-6-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAMQu2gzGBS-+GV9J+HMRQnr3c1Qk-Z2Js=G_xqMpmH4qOuFTXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2012 at 2:08 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> Add support for the new smp_twd runtime registration interface
> to the OMAP4 platforms, and remove the old compile-time support.
> Tested on Panda.
>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
