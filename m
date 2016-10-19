From: robh@kernel.org (Rob Herring)
Date: Tue, 18 Oct 2016 22:17:16 -0500
Subject: [RFC PATCH] mtd: nand: Add OX820 NAND Support
In-Reply-To: <20161018090927.1990-1-narmstrong@baylibre.com>
References: <20161018090927.1990-1-narmstrong@baylibre.com>
Message-ID: <20161018171149.vhlnuqnyn4axnk2p@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2016 at 11:09:27AM +0200, Neil Armstrong wrote:
> Add NAND driver to support the Oxford Semiconductor OX820 NAND Controller.
> This is a simple memory mapped NAND controller with single chip select and
> software ECC.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/mtd/oxnas-nand.txt         |  24 ++++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/mtd/nand/Kconfig                           |   5 +
>  drivers/mtd/nand/Makefile                          |   1 +
>  drivers/mtd/nand/oxnas_nand.c                      | 144 +++++++++++++++++++++
>  4 files changed, 174 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/oxnas-nand.txt
>  create mode 100644 drivers/mtd/nand/oxnas_nand.c
