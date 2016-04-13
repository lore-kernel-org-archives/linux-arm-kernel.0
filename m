From: tony@atomide.com (Tony Lindgren)
Date: Wed, 13 Apr 2016 12:07:49 -0700
Subject: [PATCH 3/3] ARM: dts: am43xx: add support for clkout1 clock
In-Reply-To: <570E4103.2060301@ti.com>
References: <1458158097-21137-1-git-send-email-t-kristo@ti.com>
 <1458158097-21137-4-git-send-email-t-kristo@ti.com>
 <20160412210538.GB5995@atomide.com> <570E4103.2060301@ti.com>
Message-ID: <20160413190749.GV5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [160413 05:53]:
> On 04/13/2016 12:05 AM, Tony Lindgren wrote:
> >* Tero Kristo <t-kristo@ti.com> [160316 12:55]:
> >>clkout1 clock node and its generation tree was missing. Add this based
> >>on the data on TRM and PRCM functional spec.
> >
> >Can I pick this one separately?
> 
> Yes it has no dependencies towards the other patches.

OK applying into omap-for-v4.7/dt thanks.

Tony
