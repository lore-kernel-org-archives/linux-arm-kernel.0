From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Feb 2016 17:20:27 +0100
Subject: [PATCH v3 0/6] arm: Add Artpec-6 SoC
In-Reply-To: <cover.1455205057.git.larper@axis.com>
References: <cover.1455205057.git.larper@axis.com>
Message-ID: <2697188.EpDoHh0fx4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 February 2016 17:06:15 Lars Persson wrote:
> Basic support for the Axis Artpec-6 ARM SoC. Timers, interrupts, UARTs and
> ethernet are wired up.
> 
> Changes since v2:
> - Create a syscon binding for the system controller.
> - Clock patches split out to new patch series "clk: Add Artpec-6 SoC support".

Looks all good to me now, impressive for v3 on a new platform port!

We'll apply it in the next few days, unless further review comments come in.

If you end up resending, please add my

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

	Arnd
