From: tony@atomide.com (Tony Lindgren)
Date: Fri, 26 Feb 2016 11:04:08 -0800
Subject: [PATCH 1/4] ARM: OMAP2+: Fix hwmod clock for l4_ls
In-Reply-To: <1456182245-1843-2-git-send-email-tony@atomide.com>
References: <1456182245-1843-1-git-send-email-tony@atomide.com>
 <1456182245-1843-2-git-send-email-tony@atomide.com>
Message-ID: <20160226190407.GC13417@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [160222 15:04]:
> Looks like we have few cases with wrong clock, and some
> entries with missing clock. It should always be sysclk6
> for the l4_ls instance.

FYI, applying this into omap-for-v4.6/fixes-not-urgent, and
the rest of the series into omap-for-v4.6/soc and dt
branches.

Regards,

Tony
