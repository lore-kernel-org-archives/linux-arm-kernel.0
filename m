From: tony@atomide.com (Tony Lindgren)
Date: Fri, 19 Oct 2012 08:56:12 -0700
Subject: [PATCH v2] arm: omap: move OMAP USB platform data to
 <linux/platform_data/omap-usb.h>
In-Reply-To: <20121019065500.GD12235@arwen.pp.htv.fi>
References: <20121016230040.GP15569@atomide.com>
 <1350488838-6289-1-git-send-email-balbi@ti.com>
 <20121017203404.GY15569@atomide.com>
 <20121018054934.GE11137@arwen.pp.htv.fi>
 <20121019014917.GL30550@atomide.com>
 <20121019065500.GD12235@arwen.pp.htv.fi>
Message-ID: <20121019155612.GA4730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [121019 00:01]:
> On Thu, Oct 18, 2012 at 06:49:17PM -0700, Tony Lindgren wrote:
> > 
> > Yes. Figured it out, it fails to apply with quilt, but applies
> > with git.
> 
> probably because of file rename.

Yeh so it seems.
 
> > But it does not compile with all configs though, and does
> > not remove plat/usb.h. Thanks anyways. I'll post a proper
> > series shortly with your patch fixed up.
> 
> ok... I'll check it out. I kept the non-static functions in plat/usb.h
> because they didn't belong on platform_data/usb-omap.h. What should be
> done with those, then ? move to mach/ ?

I made a clean-up patch that creates local usb.h file for those
that applies before your patch.

Regards,

Tony
