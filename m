From: tony@atomide.com (Tony Lindgren)
Date: Mon, 25 Nov 2013 15:35:46 -0800
Subject: Status of 1GHz support on am37xx
In-Reply-To: <20131122230121.GA13440@animalcreek.com>
References: <20131122230121.GA13440@animalcreek.com>
Message-ID: <20131125233545.GZ10023@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mark A. Greer <mgreer@animalcreek.com> [131122 15:02]:
> Hello.
> 
> I was wondering what that the status of 1GHz support for the am37xx is.
> 
> It looks like smartreflex/avs and ABB drivers are there.  Do they need
> more work (e.g., DT support)?  What DT nodes and related support need
> to be added?
> 
> What pieces are being worked on and which ones aren't?
> Is there an ETA for the pieces being worked on?

There are still various parts of twl4030 that are only working with
platform data, so at least those should be fixed now that we're moving
to DT only based booting for mach-omap2 for v3.14.

Regards,

Tony
