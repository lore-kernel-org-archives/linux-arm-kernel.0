From: tony@atomide.com (Tony Lindgren)
Date: Tue, 20 Dec 2016 15:04:56 -0800
Subject: [PATCHv4 00/15] clk: ti: add support for hwmod clocks
In-Reply-To: <20161220225627.GF5423@codeaurora.org>
References: <20161028233750.GQ16026@codeaurora.org>
 <7371ef35-5d95-bf78-4c97-c61091a1fa4b@ti.com>
 <148156710975.37646.2957511113527634913@resonance>
 <20161213004914.GM5423@codeaurora.org>
 <20161213013133.GR4920@atomide.com>
 <148160402543.37646.6019420188689675769@resonance>
 <4b016883-e7c9-94d8-d964-3c8dfee6ee13@ti.com>
 <20161217014626.GX5423@codeaurora.org>
 <88baee5e-48c3-f0d3-de5e-8e578fab0aa4@ti.com>
 <20161220225627.GF5423@codeaurora.org>
Message-ID: <20161220230455.GL4920@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Boyd <sboyd@codeaurora.org> [161220 14:56]:
> On 12/19, Tero Kristo wrote:
> > First thing to do here would be to implement the hwmod genpds, rest
> > can follow later, but we need an agreement if this is the way we
> > want to go.
> 
> Ok. I guess we're just waiting on Tony then?

Sounds right to me except for the hwmod genpd part.. We don't want to
pile up any new code to mach-omap2 but instead we want to make the
hwmod code into proper interconnect driver. As long as we do it that
way, sounds good to me.

Regards,

Tony
