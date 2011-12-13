From: khilman@ti.com (Kevin Hilman)
Date: Mon, 12 Dec 2011 16:33:56 -0800
Subject: [PATCHv11 0/8] OMAP3+: PRCM chain handler
In-Reply-To: <1323713733-13115-1-git-send-email-t-kristo@ti.com> (Tero
 Kristo's message of "Mon, 12 Dec 2011 20:15:25 +0200")
References: <1323713733-13115-1-git-send-email-t-kristo@ti.com>
Message-ID: <87ty55z4wb.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:


> PRCM chain handler is adding a support to the omap3+ kernel that
> allows different drivers to use PRCM interrupt events for their
> own purposes, typically this means IO wakeups. This work was
> attempted to integrate as its own driver at some point of
> the evolution of this set, however this was now postponed as
> the lacking support is basically blocking a few drivers.
>
> This is the version 11 of this set, now posted to linux-arm-kernel also
> as cc. Contains just a couple of minor changes compared to previous
> version proposed by Kevin Hilman.

Thanks Tero for the quick update.  

All of this series can go through Paul, so from my side

Reviewed-by: Kevin Hilman <khilman@ti.com>
Tested-by: Kevin Hilman <khilman@ti.com>

Kevin
