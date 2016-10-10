From: robh@kernel.org (Rob Herring)
Date: Sun, 9 Oct 2016 19:53:39 -0500
Subject: [PATCH 8/8] pinctrl: aspeed-g5: Add mux configuration for all pins
In-Reply-To: <a17175fdeaf1656afa307a180a4ab4953d4ad19c.1474986045.git-series.andrew@aj.id.au>
References: <cover.115463f791b69859c5ce9dafd61a5755ea039f4b.1474986045.git-series.andrew@aj.id.au>
 <a17175fdeaf1656afa307a180a4ab4953d4ad19c.1474986045.git-series.andrew@aj.id.au>
Message-ID: <20161010005339.GA29854@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2016 at 12:20:20AM +0930, Andrew Jeffery wrote:
> The patch introducing the g5 pinctrl driver implemented a smattering of
> pins to flesh out the implementation of the core and provide bare-bones
> support for some OpenPOWER platforms and the AST2500 evaluation board.
> Now, update the bindings document to reflect the complete functionality
> and implement the necessary pin configuration tables in the driver.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt |   17 +-

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c                   | 1476 ++++++-
>  drivers/pinctrl/aspeed/pinctrl-aspeed.h                      |    1 +-
>  3 files changed, 1487 insertions(+), 7 deletions(-)
