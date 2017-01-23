From: tony@atomide.com (Tony Lindgren)
Date: Mon, 23 Jan 2017 12:34:04 -0800
Subject: [PATCH] ARM: OMAP1/2: clock: Remove unused mpurate cmdline option
In-Reply-To: <CAPcvp5FQ90KroisJE1Hp4yx8Hz07ev_YyNgxEGtgAEUYDd1nsw@mail.gmail.com>
References: <1485020215-6550-1-git-send-email-amurray@embedded-bits.co.uk>
 <20170123151055.GQ7403@atomide.com>
 <CAPcvp5FQ90KroisJE1Hp4yx8Hz07ev_YyNgxEGtgAEUYDd1nsw@mail.gmail.com>
Message-ID: <20170123203403.GW7403@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Andrew Murray <amurray@embedded-bits.co.uk> [170123 11:52]:
> On 23 January 2017 at 15:10, Tony Lindgren <tony@atomide.com> wrote:
> > * Andrew Murray <amurray@embedded-bits.co.uk> [170121 09:38]:
> >> The 'mpurate' option, historically used for specifying an initial
> >> MPU rate at boot, no longer has any effect due to the supporting
> >> code being removed as it was 'wrong and dangerous' [1].
> >>
> >> This patch removes the remaining dead code associated with the
> >> __setup macros to avoid confusion and reduce bloat.
> >>
> >> [1] https://patchwork.kernel.org/patch/5954631/
> >
> > Yeah AFAIK this is unused for mach-omap2. Adding Aaro to
> > Cc for mach-omap1 in case there might be issues with this
> > patch.
> 
> I've also noticed that omap2_clk_print_new_rates in
> arch/arm/mach-omap2/clock.c is also unused - this was previously used
> to print the new clock rates upon change after use of mpurate.
> 
> I'll update the patch to include the removal of this function as well
> - unless you have any objections.

Sure.

Thanks,

Tony
