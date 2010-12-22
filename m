From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 21 Dec 2010 20:43:09 -0700 (MST)
Subject: [PATCH 0/5] OMAP3&4: Fixes in setup/suspend/powerdomain
In-Reply-To: <1292276969-29733-1-git-send-email-b-cousson@ti.com>
References: <1292276969-29733-1-git-send-email-b-cousson@ti.com>
Message-ID: <alpine.DEB.2.00.1012212039260.1446@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rajendra, Santosh, Beno?t, Kevin,

On Mon, 13 Dec 2010, Benoit Cousson wrote:

> This is a series of fixes on OMAP3/4 in setup apis,
> in the suspend framework and in powerdomain modelling
> for OMAP4.
> 
> The series is based on your power domain series and is available here:
> git://gitorious.org/omap-pm/linux.git for_2.6.38/power
> 
> Tested on 4430sdp + ES2.0 with omap2plus_defconfig.
> Tested on 3430sdp - validate OFF in suspend, with omap3_pm_defconfig
> from Kevin's tree.
> Tested on 2430sdp after fixing the break on linux-omap master.
> See http://www.spinics.net/lists/linux-omap/msg42050.html

Thanks, queued for 2.6.38 in the 'omap4_pm_clk_pwrdm_a_2.6.38' branch of 
git://git.pwsan.com/linux-2.6.  I used the v2 versions of the first and 
second patches.

Also added to the integration branch at tag 
'integration-2.6.38-20101221-009' of git://git.pwsan.com/linux-integration


- Paul
