From: tony@atomide.com (Tony Lindgren)
Date: Mon, 20 Mar 2017 07:34:33 -0700
Subject: [PATCHv2 5/9] ARM: OMAP2+: hwmod: assign main clock from DT if
 available
In-Reply-To: <95b7142f-8cc7-5909-764e-05dbad434298@ti.com>
References: <1489741781-12816-1-git-send-email-t-kristo@ti.com>
 <1489741781-12816-6-git-send-email-t-kristo@ti.com>
 <20170317154126.GU20572@atomide.com>
 <f7c795dc-13db-9157-cdcc-b61892cc73f9@ti.com>
 <20170317221728.GX20572@atomide.com>
 <95b7142f-8cc7-5909-764e-05dbad434298@ti.com>
Message-ID: <20170320143433.GG20572@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [170320 06:25]:
> On 18/03/17 00:17, Tony Lindgren wrote:
> > I don't quite follow you, what breaks if you fall back to the old clock
> > lookup if no "ti,hwmods" is set?
> 
> I think I misunderstood your earlier comment. So basically the code already
> bails out early if ti,hwmods is not set. In this case, the earlier lookup
> done by hwmod core sets the node pointer for this code to be NULL, and this
> just parses the existing main_clk info.

OK thanks for confirming that.

Regards,

Tony
