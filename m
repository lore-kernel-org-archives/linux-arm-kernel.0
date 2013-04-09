From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Apr 2013 14:58:03 +0200
Subject: [GIT PULL v2] imx fixes for 3.9, take 5
In-Reply-To: <20130409122435.GK5047@S2101-09.ap.freescale.net>
References: <20130409122435.GK5047@S2101-09.ap.freescale.net>
Message-ID: <201304091458.03811.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 April 2013, Shawn Guo wrote:
> The imx fixes for 3.9, take 5:
> 
> * A couple imx35 clock fixes for regressions caused by common clock
>   framework conversion.  The admux and iomux get disabled by common
>   clock framework late initcall, and hence causes problems.
> * Add missing twd clock lookup in device tree.  This becomes required
>   since commit bd60345 (ARM: use device tree to get smp_twd clock)
>   forces all DT boot to find lookup from device tree.
> * Fix imx6q ldb_di clock parents mismatch per reference manual.

Pulled into the fixes branch now, thanks for following up on this,
I didn't have any of them on my radar.

	Arnd
