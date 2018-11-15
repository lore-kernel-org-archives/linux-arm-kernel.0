From: horms@verge.net.au (Simon Horman)
Date: Thu, 15 Nov 2018 06:24:34 -0800
Subject: [PATCH 2/2] ARM: shmobile: Restrict TWD support to SoCs that
 have it
In-Reply-To: <20181115095639.17206-3-geert+renesas@glider.be>
References: <20181115095639.17206-1-geert+renesas@glider.be>
 <20181115095639.17206-3-geert+renesas@glider.be>
Message-ID: <20181115142433.o5yg73wbcezuhxt7@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 10:56:39AM +0100, Geert Uytterhoeven wrote:
> Currently support for the ARM Timer and Watchdog Unit is included
> unconditionally, while only some Renesas multicore Cortex-A9 SoCs have
> a TWD.
> 
> This decreases kernel image size by ca. 2 KiB on SoCs without a TWD.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks Geert,

applied for v4.21.
