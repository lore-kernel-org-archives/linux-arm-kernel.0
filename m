From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 16 Jul 2018 12:20:25 +0200
Subject: [PATCH v2 0/2]  reset: uniphier: add USB3 core reset support
In-Reply-To: <1531185257-16444-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1531185257-16444-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1531736425.18173.11.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kunihiko,

On Tue, 2018-07-10 at 10:14 +0900, Kunihiko Hayashi wrote:
> This series add new USB3 core reset control support for UniPhier SoCs.
> This reset line belongs to USB3 glue layer.
> 
> Changes since v1:
> - dt-bindings: fix a typo, not "clock-names" but "reset-names"
> - dt-bindings: add description of glue layer
> - reuse soc_data for pxs2, ld20 and pxs3
> - put reset_simple_data into uniphier_usb3_reset_priv
> - replace clk operations with clk_bulk
> - move nclks and nrsts to soc_data
> - rewrite a header with C++ comment style
> - change the subject 'USB3 controller reset' to 'USB3 core reset'
> 
> Kunihiko Hayashi (2):
>   dt-bindings: reset: uniphier: add USB3 core reset support
>   reset: uniphier: add USB3 core reset control

Thank you, both applied to reset/next.

regards
Philipp
