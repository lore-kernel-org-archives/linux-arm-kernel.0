From: horms@verge.net.au (Simon Horman)
Date: Thu, 30 Aug 2018 16:13:33 +0200
Subject: [PATCH v2 1/2] ARM: shmobile: Remove the ARCH_SHMOBILE Kconfig
 symbol
In-Reply-To: <20180828151011.14065-2-geert+renesas@glider.be>
References: <20180828151011.14065-1-geert+renesas@glider.be>
 <20180828151011.14065-2-geert+renesas@glider.be>
Message-ID: <20180830141332.4x3hhpt5vbomy7cu@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 05:10:10PM +0200, Geert Uytterhoeven wrote:
> All drivers for Renesas ARM SoCs have gained proper ARCH_RENESAS
> platform dependencies.  Hence finish the conversion from ARCH_SHMOBILE
> to ARCH_RENESAS for Renesas 32-bit ARM SoCs, as started by commit
> 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce ARCH_RENESAS").
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks Geert, applied for v4.20.
