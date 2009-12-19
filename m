From: tony@atomide.com (Tony Lindgren)
Date: Fri, 18 Dec 2009 21:07:30 -0800
Subject: [PATCH 0/5] V7/Cortex/omap34xx fixes for 2.6.33-rc1: DCC,
	kexec, atags
In-Reply-To: <20091219034151.26198.26570.stgit@localhost>
References: <20091219034151.26198.26570.stgit@localhost>
Message-ID: <20091219050730.GC4575@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [091218 19:44]:
> Hi all,
> 
> Here are some v7 fixes, mostly to make kexec work.
> 
> Using 2.6.33-rc1, these fixes, and kexec from kexec-tools
> git repo, I can reboot my n900 in a loop reliably.
> 
> To clarify, this works booting 2.6.33-rc1 in a loop, booting
> the Maemo kernel with kexec does not seem to boot very far
> at all for some reason. I'll look into that next.

After a quick look it seems that the Maemo kernel hangs
at dss_boottime_get_clocks(). Oh well, if anybody has
a patch for that, let me know.

Regards,

Tony
