From: tony@atomide.com (Tony Lindgren)
Date: Thu, 6 Oct 2011 13:12:25 -0700
Subject: [PATCH 0/2] ARM: OMAP2+: timer fixes / cleanup
In-Reply-To: <1317763241-21422-1-git-send-email-b-cousson@ti.com>
References: <1317763241-21422-1-git-send-email-b-cousson@ti.com>
Message-ID: <20111006201225.GS6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Benoit Cousson <b-cousson@ti.com> [111004 13:46]:
> Hi Tony,
> 
> Here is the series to fix the warning and remove the redundant
> latency structure that be removed since the timer runtime PM
> adaptation was just pulled.
> 
> I was just able to test that on OMAP4.
> 
> Patches are based on Kevin's for_3.2/omap_device-2 branch
> and are available here:
> git://gitorious.org/omap-pm/linux.git for_3.2/timer_fixes

Thanks, applying both into fixes-part2 branch.

Regards,

Tony
