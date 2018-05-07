From: robh@kernel.org (Rob Herring)
Date: Mon, 7 May 2018 16:05:30 -0500
Subject: [PATCH 3/7] pinctrl: sunxi: add support for H6 R_PIO pin
 controller
In-Reply-To: <20180503183847.11046-4-icenowy@aosc.io>
References: <20180503183847.11046-1-icenowy@aosc.io>
 <20180503183847.11046-4-icenowy@aosc.io>
Message-ID: <20180507210530.GA8285@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2018 at 02:38:43AM +0800, Icenowy Zheng wrote:
> Allwinner H6 SoC has a R_PIO pin controller like other Allwinner SoCs,
> which controls the PL and PM pin banks.
> 
> Add support for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +

Acked-by: Rob Herring <robh@kernel.org>

In the future, please split bindings to separate patches.

>  drivers/pinctrl/sunxi/Kconfig                      |   4 +
>  drivers/pinctrl/sunxi/Makefile                     |   1 +
>  drivers/pinctrl/sunxi/pinctrl-sun50i-h6-r.c        | 128 +++++++++++++++++++++
>  4 files changed, 134 insertions(+)
>  create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-h6-r.c
