From: alan@linux.intel.com (Alan Cox)
Date: Tue, 11 Sep 2012 20:19:19 +0100
Subject: [PATCH 09/17] serial/8250: Limit the omap workarounds to omap1
In-Reply-To: <20120911164023.GE23092@atomide.com>
References: <20120911052934.29637.9190.stgit@muffinssi.local>
 <20120911053104.29637.95283.stgit@muffinssi.local>
 <20120911174234.45919fd3@bob.linux.org.uk>
 <20120911164023.GE23092@atomide.com>
Message-ID: <20120911201919.58d44dcb@bob.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Even better would be if for other cases is_omap_port and friends
> > returned 0...
> 
> Yes it seems that those macros could be moved from plat-omap/serial.h
> to live in drivers/tty/serial/8250/8250.h? Or do you have some better
> place in mind?

I've not looked at it enough to decide if it's doable or not. I'm happy
either way - both patches are progress the right way!
