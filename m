From: tony@atomide.com (Tony Lindgren)
Date: Mon, 6 Mar 2017 10:38:57 -0800
Subject: [PATCH 0/3] ARM: PM: Drop useless checks for PM_SUSPEND_STANDBY
In-Reply-To: <20170217164018.GE21809@atomide.com>
References: <1487347836-14427-1-git-send-email-geert+renesas@glider.be>
 <20170217164018.GE21809@atomide.com>
Message-ID: <20170306183856.GM20572@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [170217 08:41]:
> * Geert Uytterhoeven <geert+renesas@glider.be> [170217 08:12]:
> > 	Hi all,
> > 
> > The system suspend implementations for DaVinci, OMAP, and SoCFPGA use
> > the standard suspend_valid_only_mem() for their
> > platform_suspend_ops.valid() callbacks.  Hence their
> > platform_suspend_ops.enter() callbacks will never be called with state
> > equal to PM_SUSPEND_STANDBY, and checks for this can thus be removed.
> > 
> > Thanks for your comments!
> 
> Seems safe to remove:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Sounds like you wanted me to pick this up so applying the
omap related patch into omap-for-v4.12/soc.

Thanks,

Tony
