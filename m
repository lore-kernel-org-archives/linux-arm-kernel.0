From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 21 Jul 2017 15:49:59 -0700
Subject: [PATCH] clk: Convert to using %pOF instead of full_name
In-Reply-To: <20170718214339.7774-12-robh@kernel.org>
References: <20170718214339.7774-12-robh@kernel.org>
Message-ID: <20170721224959.GA2146@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: "Emilio L?pez" <emilio@elopez.com.ar>
> Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
> Cc: Prashant Gaikwad <pgaikwad@nvidia.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: linux-clk at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-mediatek at lists.infradead.org
> Cc: linux-renesas-soc at vger.kernel.org
> Cc: linux-tegra at vger.kernel.org
> Cc: linux-omap at vger.kernel.org
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
