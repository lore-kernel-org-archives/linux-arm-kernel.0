From: tony@atomide.com (Tony Lindgren)
Date: Fri, 17 Jul 2015 06:47:19 -0700
Subject: [PATCH 0/2] Drop two more omap3 legacy board files for v4.3
 merge window
In-Reply-To: <20150717082645.GB9331@earth>
References: <1437047951-22300-1-git-send-email-tony@atomide.com>
 <20150717082645.GB9331@earth>
Message-ID: <20150717134719.GT17550@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sebastian Reichel <sre@kernel.org> [150717 01:29]:
> Hi,
> 
> On Thu, Jul 16, 2015 at 04:59:09AM -0700, Tony Lindgren wrote:
> > I think we can drop these now. This just leaves n900 and ldp with
> > n900 pending patches for legacy proc support.
> 
> So I guess n900 board file removal depends on the atag procfs
> support in DT. What's the problem with ldp? Its DT file seem
> to cover everything in the board file. I guess both of them
> will finally be removed in 4.4?

Yes the atags procfs and setting system_rev as being discussed
with the patches posted by Pali.

LDP actually works better with device tree, we just want to keep
the legacy booting around until the n900 issues are sorted out
as it's hooked to Russell's build and boot test rack.

Regards,

Tony
