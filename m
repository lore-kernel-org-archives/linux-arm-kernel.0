From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 20 Feb 2017 15:59:36 +0530
Subject: [PATCH 2/4] ARM: dts: da850: add vpif video display pins
In-Reply-To: <1487268932-6469-3-git-send-email-bgolaszewski@baylibre.com>
References: <1487268932-6469-1-git-send-email-bgolaszewski@baylibre.com>
 <1487268932-6469-3-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <318d9f87-ad2a-c0e1-255a-097056c0f85f@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 February 2017 11:45 PM, Bartosz Golaszewski wrote:
> Add a new pinctrl sub-node for vpif display pins. Move VP_CLKIN3 and
> VP_CLKIN2 to the display node where they actually belong (vide section
> 35.2.2 of the da850 datasheet).

You mean 36.2.2. Also, its in the technical reference manual (TRM). The
datahseet is another document.

> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/boot/dts/da850-evm.dts |  2 +-
>  arch/arm/boot/dts/da850.dtsi    | 17 +++++++++++++++--

Can you separate out the board and SoC specific changes? The board
changes could be done in patch 3/4 where other video output parts are added.

Thanks,
Sekhar
