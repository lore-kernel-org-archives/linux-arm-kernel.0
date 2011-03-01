From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 1 Mar 2011 11:28:49 +0530
Subject: [PATCH 2/5] ARM: gic: Add distributor and interface
	enable/disable accessory api
In-Reply-To: <1295859080-15259-3-git-send-email-santosh.shilimkar@ti.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
	<1295859080-15259-3-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <40fac4df5423b501f2b3eca514e62b99@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar at ti.com]
> Sent: Monday, January 24, 2011 2:21 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: linux-omap at vger.kernel.org; ccross at android.com;
> catalin.marinas at arm.com; linux at arm.linux.org.uk;
> linus.ml.walleij at gmail.com; Santosh Shilimkar; Russell King
> Subject: [PATCH 2/5] ARM: gic: Add distributor and interface
> enable/disable accessory api
>
> The power management code needs to have access to enable/disable the
> gic cpu interface and distributor based on targetted low power
> states.
>
> This patch adds and exports one API each for distributor and cpu
> interface enable/disable.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
As per off-the list discussion with Russell, I am going to drop
this patch for time being and handle this in OMAP code instead
till common GIC code refactoring is sorted out.
