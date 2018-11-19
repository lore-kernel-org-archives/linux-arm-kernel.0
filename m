From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 19 Nov 2018 10:25:53 +0100
Subject: [PATCH 0/4] reset: uniphier: Rename from USB3 reset to glue
 reset and add AHCI reset support
In-Reply-To: <1541727727-10821-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1541727727-10821-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1542619553.5139.1.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-11-09 at 10:42 +0900, Kunihiko Hayashi wrote:
> This series renames the reset control of core reset included in USB3 glue
> layer with in the glue layer for generic peripherals to allow other devices
> to use it.
> 
> And this series adds support for the core reset included in AHCI glue layer.
> 
> Kunihiko Hayashi (4):
>   dt-bindings: reset: uniphier: Replace the expression of USB3 with
>     generic peripherals
>   reset: uniphier-usb3: Rename to reset-uniphier-glue
>   dt-bindings: reset: uniphier: Add AHCI core reset description
>   reset: uniphier-glue: Add AHCI reset control support in glue layer

Thank you, applied to reset/next.

regards
Philipp
