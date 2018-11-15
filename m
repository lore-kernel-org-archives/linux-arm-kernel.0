From: horms@verge.net.au (Simon Horman)
Date: Thu, 15 Nov 2018 06:22:22 -0800
Subject: [PATCH] arm64: renesas: Enable GPIOLIB to allow GPIO driver
 selection
In-Reply-To: <20181115094649.16675-1-geert+renesas@glider.be>
References: <20181115094649.16675-1-geert+renesas@glider.be>
Message-ID: <20181115142221.dmuxnkvje3dk4el6@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 10:46:49AM +0100, Geert Uytterhoeven wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> 
> The R-Car GPIO driver cannot be enabled when Renesas SoC's ARCH configs
> (ARCH_RENESAS, ARCH_R8A7795, ARCH_R8A7796 and ARCH_R8A77965) are enabled
> only.
> 
> As GPIOs are a critical resource for proper operation on Renesas
> platforms, this patch selects GPIOLIB, just like is done for other SoC
> vendors, and on Renesas arm32 SoCs.
> 
> Reported-by: Alexandru Gheorghe <Alexandru_Gheorghe@mentor.com>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> [geert: Improve patch description]
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks Geert,

applied for v4.21.
