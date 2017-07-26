From: tony@atomide.com (Tony Lindgren)
Date: Wed, 26 Jul 2017 01:17:17 -0700
Subject: [PATCH] ARM: OMAP2+: omap_device: drop broken RPM status update
 from suspend_noirq
In-Reply-To: <20170726075004.GD27516@localhost>
References: <20170724095201.21601-1-johan@kernel.org>
 <05ae4585-8da0-6fb1-8cfd-6b236ec3a8a2@ti.com>
 <20170725082444.GL2729@localhost>
 <3f0f8ed2-9466-d5c9-10e4-de95e5155653@ti.com>
 <20170726075004.GD27516@localhost>
Message-ID: <20170726081716.GB10026@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Johan Hovold <johan@kernel.org> [170726 00:51]:
> On Tue, Jul 25, 2017 at 12:48:40PM -0500, Grygorii Strashko wrote:
> > So, thank you for your patches and sorry for the noise.
> > 
> > Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> Thanks for testing.

So does the patch description need updating? And this is needed
as a fix for the -rc cycle in addition to your musb patch?

Regards,

Tony
