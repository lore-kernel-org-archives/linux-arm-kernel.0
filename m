From: robh@kernel.org (Rob Herring)
Date: Fri, 23 Sep 2016 12:48:28 -0500
Subject: [PATCH] ARM: dts: imx31: fix clock control module interrupts
 description
In-Reply-To: <1474250074-11430-1-git-send-email-vz@mleia.com>
References: <1474250074-11430-1-git-send-email-vz@mleia.com>
Message-ID: <20160923174828.GA1426@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2016 at 04:54:34AM +0300, Vladimir Zapolskiy wrote:
> The type of AVIC interrupt controller found on i.MX31 is one-cell,
> namely 31 for CCM DVFS and 53 for CCM, however for clock control
> module its interrupts are specified as 3-cells, fix it.
> 
> Fixes: ef0e4a606fb6 ("ARM: mx31: Replace clk_register_clkdev with clock DT lookup")
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  Documentation/devicetree/bindings/clock/imx31-clock.txt | 2 +-
>  arch/arm/boot/dts/imx31.dtsi                            | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
