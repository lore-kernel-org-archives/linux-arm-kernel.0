From: tony@atomide.com (Tony Lindgren)
Date: Fri, 25 Apr 2014 09:27:59 -0700
Subject: [PATCH v2] ARM: OMAP5: Switch to THUMB mode if needed on
 secondary CPU
In-Reply-To: <1398195639-29273-1-git-send-email-joelf@ti.com>
References: <1398195639-29273-1-git-send-email-joelf@ti.com>
Message-ID: <20140425162758.GB20807@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Joel Fernandes <joelf@ti.com> [140422 12:41]:
> On my DRA7 system, when the kernel is built in Thumb-2 mode, the secondary CPU
> (Cortex A15) fails to come up causing SMP boot on second CPU to timeout. This
> seems to be because the CPU is in ARM mode once the ROM hands over control to
> the kernel.  Switch to Thumb-2 mode if required once the kernel is control of
> secondary CPU. On OMAP4 on the other hand, it appears to be in Thumb-2 mode on
> entry so this is not required and SMP boot works as is.
> 
> Also corrected a spurious '+' and updated copyright information.
> 
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Tested-by: Nishanth Menon <nm@ti.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Joel Fernandes <joelf@ti.com>

Thanks applying into omap-for-v3.15/fixes-v2.

Tony
