From: horms@verge.net.au (Simon Horman)
Date: Thu, 30 Aug 2018 16:17:59 +0200
Subject: [PATCH v2 2/2] arm64: renesas: Remove the ARCH_SHMOBILE Kconfig
 symbol
In-Reply-To: <20180828151011.14065-3-geert+renesas@glider.be>
References: <20180828151011.14065-1-geert+renesas@glider.be>
 <20180828151011.14065-3-geert+renesas@glider.be>
Message-ID: <20180830141758.2eo2fijrdn2pbovy@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 05:10:11PM +0200, Geert Uytterhoeven wrote:
> The Kconfig symbol for Renesas 64-bit ARM SoCs has always been
> ARCH_RENESAS, with ARCH_SHMOBILE being selected to reuse drivers shared
> with Renesas 32-bit ARM and/or Renesas SuperH SH-Mobile SoCs.
> 
> Commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce ARCH_RENESAS")
> started the conversion from ARCH_SHMOBILE to ARCH_RENESAS for Renesas
> 32-bit SoCs.  Now all drivers for Renesas ARM SoCs have gained proper
> ARCH_RENESAS platform dependencies, there is no longer a need to select
> ARCH_SHMOBILE.
> 
> With ARCH_SHMOBILE gone, move the ARCH_RENESAS section up, to restore
> alphabetical sort order.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks Geert, applied for v4.20.
