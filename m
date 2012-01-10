From: khilman@ti.com (Kevin Hilman)
Date: Tue, 10 Jan 2012 09:36:40 -0800
Subject: [PATCHV2 REPOST 4/7] ARM: OMAP3 PM: Enable IO Wake up
In-Reply-To: <1323878477-21122-5-git-send-email-vishwanath.bs@ti.com>
 (Vishwanath BS's message of "Wed, 14 Dec 2011 21:31:14 +0530")
References: <1323878477-21122-1-git-send-email-vishwanath.bs@ti.com>
 <1323878477-21122-5-git-send-email-vishwanath.bs@ti.com>
Message-ID: <87ehv7sbmf.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vishwanath BS <vishwanath.bs@ti.com> writes:

> Enable IO Wake up for OMAP3 as part of PM Init.
> Currently this has been managed in cpuidle path which is not the right place.
> Subsequent patch will remove IO Daisy chain handling in cpuidle path once daisy
> chain is handled as part of hwmod mux.
>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> Tested-by: Govindraj.R <govindraj.raja@ti.com>


WARNING: line over 80 characters
#27: FILE: arch/arm/mach-omap2/pm34xx.c:840:
+		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
