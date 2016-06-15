From: tony@atomide.com (Tony Lindgren)
Date: Wed, 15 Jun 2016 04:02:02 -0700
Subject: [PATCH 1/2] ARM: OMAP2+: Drop legacy board file for n900
In-Reply-To: <20160615105552.GN29844@pali>
References: <1465987689-14812-1-git-send-email-tony@atomide.com>
 <1465987689-14812-2-git-send-email-tony@atomide.com>
 <20160615105552.GN29844@pali>
Message-ID: <20160615110201.GY22406@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Pali Roh?r <pali.rohar@gmail.com> [160615 03:58]:
> Hi! I just quickly looked at N900 status matrix https://elinux.org/N900
> and there is still one thing not finished in DT: It is slot-name for
> omap_hsmmc driver. So switch from legacy board code to DT is regression.

That's fixed with the following in v4.7-rc series:

db863d896681 ("mmc: omap_hsmmc: Check if MMC slot name is passed in pdata")
10c1f7d32bf4 ("ARM: OMAP2+: n900 needs MMC slot names for legacy user space")

I think Ivaylo already also backported those to the N900 tree?

Regards,

Tony
