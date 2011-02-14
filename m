From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Feb 2011 15:03:53 +0100
Subject: [[PATCH 1/4] arm: mach-mmp: Fix Kconfig to allow correct PXA
	Selections
In-Reply-To: <CEFFF7FE-F2F8-47EB-948A-C79301FEB82A@marvell.com>
References: <CEFFF7FE-F2F8-47EB-948A-C79301FEB82A@marvell.com>
Message-ID: <201102141503.53189.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 February 2011, Philip Rakity wrote:
> The following items are fixed:
> 
> a) inconsistent behavior when board is selected and if
> menu item is reselected board has disappeard
> 
> b) Ability to select options that will not build
>         MMP2 and say PXA168
> 
> The behavior maps what is done by the mach-omap
> (thanks to Anrd Bergmann for his help and suggestions)
> 
> Mach-MMP is (as now) the sytem type.  Once selected
> the user can then select the SoC on the board and
> only the boards that support that SoC are shown.
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
