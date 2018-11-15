From: horms@verge.net.au (Simon Horman)
Date: Thu, 15 Nov 2018 06:24:05 -0800
Subject: [PATCH 1/2] ARM: shmobile: Restrict SCU support to SoCs that
 have it
In-Reply-To: <20181115095639.17206-2-geert+renesas@glider.be>
References: <20181115095639.17206-1-geert+renesas@glider.be>
 <20181115095639.17206-2-geert+renesas@glider.be>
Message-ID: <20181115142404.ajjkuldlxktj7o7m@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 10:56:38AM +0100, Geert Uytterhoeven wrote:
> Currently support for the ARM Cortex-A9 Snoop Control Unit is included
> unconditionally, while only Renesas multicore Cortex-A9 SoCs have this
> kind of SCU.
> 
> This decreases kernel image size by ca. 300 bytes on SoCs without such
> an SCU.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks Geert, applied for v4.21.
