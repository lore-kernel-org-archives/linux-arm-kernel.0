From: robh@kernel.org (Rob Herring)
Date: Mon, 1 Feb 2016 08:09:31 -0600
Subject: [PATCH] pinctrl: sunxi: Add H3 R_PIO controller support
In-Reply-To: <20160201101225.GA19687@box2.japko.eu>
References: <20160201101225.GA19687@box2.japko.eu>
Message-ID: <20160201140931.GA7238@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 01, 2016 at 11:12:26AM +0100, Krzysztof Adamski wrote:
> H3 has additional PIO controller similar to what we can find on A23.
> It's a 12 pin port, described in H3 Datasheet rev 1.1, pages 345-350.
> 
> Signed-off-by: Krzysztof Adamski <k@japko.eu>
> ---
> .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +
> arch/arm/boot/dts/sun8i-h3.dtsi                    |  12 +++

Acked-by: Rob Herring <robh@kernel.org>

> drivers/pinctrl/sunxi/Kconfig                      |   4 +
> drivers/pinctrl/sunxi/Makefile                     |   1 +
> drivers/pinctrl/sunxi/pinctrl-sun8i-h3-r.c         | 105 +++++++++++++++++++++
> 5 files changed, 123 insertions(+)
> create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun8i-h3-r.c
