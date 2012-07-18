From: tony@atomide.com (Tony Lindgren)
Date: Wed, 18 Jul 2012 00:20:53 -0700
Subject: [PATCH 1/1] ARM: OMAP3: igep0020: set GPIO mode for mux
 mcspi1_cs2 pin
In-Reply-To: <CABxcv=miEavW5Qf-Y+S4Nph+ah5gQ6QDpt-T44tdHLBxcP8pqQ@mail.gmail.com>
References: <1341885452-5372-1-git-send-email-javier@dowhile0.org>
 <CAFqH_511c6CyAYnbtU0ECZwzRNwJEdTqtcZ63nODCYZU4GC0aA@mail.gmail.com>
 <CABxcv=miEavW5Qf-Y+S4Nph+ah5gQ6QDpt-T44tdHLBxcP8pqQ@mail.gmail.com>
Message-ID: <20120718072052.GK6522@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Javier Martinez Canillas <javier@dowhile0.org> [120717 00:16]:
> 
> Hi Tony,
> 
> Just pinging to see if you have further comments on this patch or if
> it can be applied. It solves a bug on IGEPv2 boards.
> 
> I know the trend is to move away from board code. I'll start working
> on an device tree for the IGEPv2 but it will take some time until is
> ready (and I'm not sure if all the OMAP3 support is already present on
> DT).
> 
> So could you please take bug fixes for the board code in the meantime?

Yes seems like something for the v3.6-rc series.

Regards,

Tony
