From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 08 Jan 2014 01:49:18 +0100
Subject: [PATCH] ARM: SAMSUNG: remove obsolete tick.h
In-Reply-To: <1907750.XQ1uIOEDlS@phil>
References: <1907750.XQ1uIOEDlS@phil>
Message-ID: <2341825.uZDBWhHeIh@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Tuesday 07 of January 2014 21:53:51 Heiko St?bner wrote:
> Commit 48cf83dc12f2 (ARM: samsung: remove unused tick.h) removed some
> occurences of tick.h. tick.h itself and s3c24xx_ostimer_pending was only
> used by the old timer driver and is not used anymore.
> 
> Therefore remove the last 3 occurences.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm/mach-s3c24xx/include/mach/tick.h |   15 --------------
>  arch/arm/mach-s3c64xx/include/mach/tick.h |   31 -----------------------------
>  arch/arm/mach-s5pc100/include/mach/tick.h |   31 -----------------------------
>  3 files changed, 77 deletions(-)
>  delete mode 100644 arch/arm/mach-s3c24xx/include/mach/tick.h
>  delete mode 100644 arch/arm/mach-s3c64xx/include/mach/tick.h
>  delete mode 100644 arch/arm/mach-s5pc100/include/mach/tick.h

Thanks for cleaning this up.

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
