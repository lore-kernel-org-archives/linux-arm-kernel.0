From: tony@atomide.com (Tony Lindgren)
Date: Mon, 25 Jun 2018 01:04:16 -0700
Subject: [PATCH] ARM: DRA7/OMAP5: Enable ACTLR[0] (Enable invalidates of
 BTB) for secondary cores
In-Reply-To: <20180625080309.GH112168@atomide.com>
References: <20180612213611.2484-1-nm@ti.com>
 <20180613101153.GD6920@n2100.armlinux.org.uk>
 <20180613132910.wr7ngq4nvxlgaoqi@kahuna>
 <20180625080309.GH112168@atomide.com>
Message-ID: <20180625080416.GI112168@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [180625 01:03]:
> * Nishanth Menon <nm@ti.com> [180613 13:31]:
> > 
> > If the above explanation makes sense, I will add that to the commit log
> > as well.
> 
> Probably good idea to also add a comment to the code that this
> is for the secondary core.

Or rename the function to make it specific to secondary core.

Regards,

Tony
