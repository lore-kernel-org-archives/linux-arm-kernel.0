From: tony@atomide.com (Tony Lindgren)
Date: Thu, 6 Sep 2012 14:02:35 -0700
Subject: [PATCH v3 10/14] ARM: OMAP/ASoC: Zoom2: Let the codec to
 handle the hs_extmute GPIO
In-Reply-To: <1346933541-21547-11-git-send-email-peter.ujfalusi@ti.com>
References: <1346933541-21547-1-git-send-email-peter.ujfalusi@ti.com>
 <1346933541-21547-11-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120906210235.GP1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120906 05:13]:
> Remove the use of set_hs_extmute callback and let the codec driver to
> handle the extmute GPIO.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  arch/arm/mach-omap2/board-zoom-peripherals.c  | 9 ++-------
>  arch/arm/mach-omap2/include/mach/board-zoom.h | 2 --

Here board-zoom.h will be moved to be just #include "board-zoom.h".
But we can deal with that once I have an immutable header cleanup
branch that you can pull in.

Acked-by: Tony Lindgren <tony@atomide.com>
