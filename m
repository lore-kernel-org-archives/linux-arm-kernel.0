From: robh@kernel.org (Rob Herring)
Date: Thu, 14 Jan 2016 21:04:00 -0600
Subject: [PATCH v2 08/26] clk: sun5i: add DRAM gates
In-Reply-To: <1452785109-6172-9-git-send-email-maxime.ripard@free-electrons.com>
References: <1452785109-6172-1-git-send-email-maxime.ripard@free-electrons.com>
 <1452785109-6172-9-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160115030400.GA19274@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2016 at 04:24:51PM +0100, Maxime Ripard wrote:
> The Allwinner SoCs have a gate controller to gate the access to the DRAM
> clock to the some devices that need to access the DRAM directly (mostly
> display / image related IPs).
> 
> Use a simple gates driver to support the one found in the A13 / R8 SoCs.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt | 1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/clk/sunxi/clk-simple-gates.c              | 2 ++
>  2 files changed, 3 insertions(+)
