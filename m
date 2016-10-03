From: robh@kernel.org (Rob Herring)
Date: Mon, 3 Oct 2016 14:08:33 -0500
Subject: [PATCH 7/8] pinctrl: aspeed-g4: Add mux configuration for all pins
In-Reply-To: <e0d8fa6cd444972e6f048f98da98f0439e6ca39b.1474986045.git-series.andrew@aj.id.au>
References: <cover.115463f791b69859c5ce9dafd61a5755ea039f4b.1474986045.git-series.andrew@aj.id.au>
 <e0d8fa6cd444972e6f048f98da98f0439e6ca39b.1474986045.git-series.andrew@aj.id.au>
Message-ID: <20161003190833.GA3065@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2016 at 12:20:19AM +0930, Andrew Jeffery wrote:
> The patch introducing the g4 pinctrl driver implemented a smattering of
> pins to flesh out the implementation of the core and provide bare-bones
> support for some OpenPOWER platforms. Now, update the bindings document
> to reflect the complete functionality and implement the necessary pin
> configuration tables in the driver.

We prefer bindings to be complete if possible where as drivers can be 
expanded over time.

> 
> Cc: Timothy Pearson <tpearson@raptorengineering.com>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt |   19 +-

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c                   | 1094 ++++++-
>  2 files changed, 1093 insertions(+), 20 deletions(-)
