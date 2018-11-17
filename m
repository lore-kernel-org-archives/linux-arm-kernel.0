From: robh@kernel.org (Rob Herring)
Date: Sat, 17 Nov 2018 10:30:13 -0600
Subject: [PATCH 1/4] dt-bindings: reset: uniphier: Replace the expression
 of USB3 with generic peripherals
In-Reply-To: <1541727727-10821-2-git-send-email-hayashi.kunihiko@socionext.com>
References: <1541727727-10821-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1541727727-10821-2-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <20181117163013.GA4481@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  9 Nov 2018 10:42:04 +0900, Kunihiko Hayashi wrote:
> Replace the expression of "USB3 glue layer" with the glue layer of the
> generic peripherals to allow other devices to use it. The reset control
> belongs to this glue layer.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../devicetree/bindings/reset/uniphier-reset.txt   | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
