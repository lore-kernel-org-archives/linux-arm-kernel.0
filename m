From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Fri, 12 Jun 2015 19:54:02 +0200
Subject: Running kexec on mx6
In-Reply-To: <CAOMZO5BsH=7yOa0fs5mtSdD2GF3hTa=+Kmtp0LqiOdFCCwNQhQ@mail.gmail.com>
References: <CAOMZO5A_=okeGhRjRb-7xkO7RJKTECdgBxinrTLtVR+6TMpnVw@mail.gmail.com>
 <CAOMZO5A0+SSdT5mfy7fmO4DUQKimQpFCSu16EVLkxR+qh6137A@mail.gmail.com>
 <20150612140123.GA7557@n2100.arm.linux.org.uk>
 <CAOMZO5BsH=7yOa0fs5mtSdD2GF3hTa=+Kmtp0LqiOdFCCwNQhQ@mail.gmail.com>
Message-ID: <20150612175402.GO17968@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 12, 2015 at 11:06:39AM -0300, Fabio Estevam wrote:
> On Fri, Jun 12, 2015 at 11:01 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> > Has it ever worked, or is this a regression?
> 
> It is my first time using kexec. Also tested running a 3.10 kernel and
> it also failed, so I think kexec has never worked on mx6.

We have used kexec on MX6 before. Adding Philipp to Cc:.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
