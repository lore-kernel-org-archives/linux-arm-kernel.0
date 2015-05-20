From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 May 2015 10:46:49 -0700
Subject: [PATCHv2 02/27] clk: ti: move generic OMAP DPLL implementation
 under drivers/clk
In-Reply-To: <555CC7CA.2090104@ti.com>
References: <1431334493-24455-1-git-send-email-t-kristo@ti.com>
 <1431334493-24455-3-git-send-email-t-kristo@ti.com>
 <20150520012053.GC31054@codeaurora.org> <555CC7CA.2090104@ti.com>
Message-ID: <20150520174648.GC10274@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [150520 10:45]:
> On 05/20/2015 04:20 AM, Stephen Boyd wrote:
> >On 05/11, Tero Kristo wrote:
> >>With the legacy clock data now gone, we can start moving OMAP clock
> >>type implementations under clock driver. Start this with moving the
> >>generic OMAP DPLL clock type under TI clock driver.
> >>
> >>Signed-off-by: Tero Kristo <t-kristo@ti.com>
> >>---
> >
> >How much of the code is the same from the original copy? Can you
> >generate these patches with -M -C so that we can see?
> 
> Looks like for the move patches the range is from 85%...95% exact copy.
> Shall I repost the patches in this format? Good hint for the -M -C btw, I
> wonder why those are not default options for git-format-patch.

While tweaking your scripts.. Can you also check why the cover
letter for your patches is missing the whole series diffstat?

The diffstat is automatically created with:

$ git format-patch --cover-letter -o /tmp/outgoing v4.1-rc1..

Regards,

Tony
