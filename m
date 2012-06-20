From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 Jun 2012 04:41:49 -0700
Subject: [PATCH 04/29] ARM: omap: clk: use clk_prepare_enable and
 clk_disable_unprepare
In-Reply-To: <4FDAC07A.7020702@ti.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
 <1339678038-23082-5-git-send-email-rnayak@ti.com>
 <20120614191147.GP19410@gmail.com> <4FDAC07A.7020702@ti.com>
Message-ID: <20120620114149.GG12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [120614 22:01]:
> On Friday 15 June 2012 12:41 AM, Mike Turquette wrote:
> >On 20120614-18:16, Rajendra Nayak wrote:
> >>As we move to Common clk framework use clk_prepare_enable()
> >>instead of clk_enable() and similarly clk_disable_unprepare()
> >>instead of clk_disable()
> >>
> >>Based on initial changes from Mike turquette.

Sounds like these kind of patches should be a separate series
to prepare for the common clk fwk conversion? It seems these
could already get merged separately?

Tony
