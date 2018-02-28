From: tony@atomide.com (Tony Lindgren)
Date: Wed, 28 Feb 2018 14:11:05 -0800
Subject: [PATCH v2] clocksource: timer-ti-dm: Make unexported functions
 static
In-Reply-To: <20180228072519.GA8961@lenoch>
References: <20180228072519.GA8961@lenoch>
Message-ID: <20180228221105.GK5448@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ladislav Michl <ladis@linux-mips.org> [180228 07:26]:
> As dmtimer no longer exports functions, make those previously
> exported static (this requires few functions to be moved around
> as their prototypes were deleted).
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> ---
>  Changes:
>  - v2: Fix compilation for OMAP1

Thanks for fixing this, applying into omap-for-v4.17/timer.

Regards,

Tony
