From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Jan 2015 20:26:22 +0100
Subject: [PATCH v3 0/5] Add common clock support for Broadcom iProc
 architecture
In-Reply-To: <1420658568-22879-1-git-send-email-rjui@broadcom.com>
References: <1420658568-22879-1-git-send-email-rjui@broadcom.com>
Message-ID: <3144204.or2m7FRv17@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 January 2015 11:22:43 Ray Jui wrote:
> This patchset contains the initial common clock support for Broadcom's iProc
> family of SoCs. The iProc clock architecture comprises of various PLLs, e.g.,
> ARMPLL, GENPLL, LCPLL0, MIPIPLL, and etc. An onboard crystal serves as the
> basic reference clock for these PLLs. Each PLL may have several leaf clocks.
> One special group of clocks is the ASIU clocks, which are dervied directly
> from the crystal reference clock.
> 

Looks good to me now.

	Arnd
