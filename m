From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Mar 2018 16:22:44 -0600
Subject: [PATCH 1/2] clk: imx: imx7d: add the Keypad Port module clock
In-Reply-To: <20180227160544.11446-1-stefan@agner.ch>
References: <20180227160544.11446-1-stefan@agner.ch>
Message-ID: <20180305222244.xa42gzjru2ysezyu@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 27, 2018 at 05:05:43PM +0100, Stefan Agner wrote:
> According to the i.MX7D Reference Manual, the Keypad Port module
> (KPP) requires this clock gate to be enabled.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/clk/imx/clk-imx7d.c             | 1 +
>  include/dt-bindings/clock/imx7d-clock.h | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
