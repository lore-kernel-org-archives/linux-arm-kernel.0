From: coelho@ti.com (Luciano Coelho)
Date: Fri, 26 Apr 2013 09:31:48 +0300
Subject: [PATCH 0/3] WLAN support for omap4 when booted with devicetree
In-Reply-To: <20130426034858.26065.65118.stgit@muffinssi.local>
References: <20130426034858.26065.65118.stgit@muffinssi.local>
Message-ID: <1366957908.4029.15.camel@cumari.coelho.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-04-25 at 20:52 -0700, Tony Lindgren wrote:
> Hi all,

Hi Tony,


> Here are some patches against linux next to make WLAN to work with
> device tree. Note that we still are initializing wl12xx with pdata,
> but so far it looks like only minimal binding for it is needed.

Thanks for doing this! I've been out on vacation for the past 3 weeks,
so I didn't manage to finish the wl12xx DT stuff in time for 3.10. :(


> There are various fixes pending posted recently, but at least the
> fix "[PATCH] mmc: omap_hsmmc: Fix the DT pbias workaround for MMC
> controllers 2 to 5" is needed.

I managed to apply the OMAP2+ and the blaze patches.  There were
conflicts with the panda patch, so I skipped it for now.  I'll come back
to it a bit later.


> Please test on blaze/sdp if you have a chance, I don't have the
> connectivity card on mine.

I tested this on Blaze and it seems to work fine! The driver gets probed
and I can power the chip on and off (by putting the interface up and
down) without any problems. :)

BTW, did you (or anyone else) manage to get ethernet to work on Blaze
(or Panda) with DT?

-- 
Luca.
