From: tony@atomide.com (Tony Lindgren)
Date: Thu, 22 Feb 2018 09:20:29 -0800
Subject: [PATCH] ARM: OMAP2+: hwmod_core: enable optional clocks before
 main clock
In-Reply-To: <f3425037-659b-238a-c77b-357c7363074d@ti.com>
References: <1513934763-23966-1-git-send-email-t-kristo@ti.com>
 <f9fea9e3-7ebb-9a78-92fc-85b7afe3a525@ti.com>
 <20171222185118.GA3875@atomide.com>
 <f3425037-659b-238a-c77b-357c7363074d@ti.com>
Message-ID: <20180222171452.GA5184@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [180220 11:21]:
> I think this missed the merge for some reason? Can you queue this up as a
> fix as its still needed?

Yes sorry I noticed too it missed the merge window. I sent
a pull request for that last week in the fixes:

[GIT PULL] omap fixes for v4.16-rc cycle

So it should get there hopefully this week.

Regards,

Tony
