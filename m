From: tony@atomide.com (Tony Lindgren)
Date: Wed, 8 Nov 2017 14:57:12 -0800
Subject: [PATCH v2 0/7] omap: dmtimer: Move driver out of plat-omap
In-Reply-To: <1510144108-29563-1-git-send-email-j-keerthy@ti.com>
References: <1510144108-29563-1-git-send-email-j-keerthy@ti.com>
Message-ID: <20171108225712.GX28152@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Keerthy <j-keerthy@ti.com> [171108 04:30]:
> The series moves dmtimer out of plat-omap to drivers/clocksource.
> The series also does a bunch of changes to pwm-omap-dmtimer code
> to adapt to the driver migration and clean up plat specific
> pdata-quirks and use the dmtimer platform data.
> 
> Boot tested on DRA7-EVM and AM437X-GP-EVM.
> 
> More testing would be of great help. 
> 
> No code changes in this v2 version. Only enhanced patch
> statistics for renames.

OK Cool.

Thierry, can you please take a look at the driver code and see if
you want other clean-ups done before moving this to drivers?

For merging, I can set up an immutable branch for this against
v4.15-rc1 when it's out and no more comments. That way we both
can then merge it in as needed.

Regards,

Tony
