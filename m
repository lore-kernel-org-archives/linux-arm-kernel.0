From: robh@kernel.org (Rob Herring)
Date: Wed, 11 Jul 2018 13:37:30 -0600
Subject: [PATCH v2 1/2] dt-bindings: reset: uniphier: add USB3 core reset
 support
In-Reply-To: <1531185257-16444-2-git-send-email-hayashi.kunihiko@socionext.com>
References: <1531185257-16444-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1531185257-16444-2-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <20180711193730.GA31593@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 10:14:16AM +0900, Kunihiko Hayashi wrote:
> Add DT bindings for reset control of USB3 core implemented in UniPhier SoCs.
> The reset control belongs to USB3 glue layer.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../devicetree/bindings/reset/uniphier-reset.txt   | 56 ++++++++++++++++++++++
>  1 file changed, 56 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
