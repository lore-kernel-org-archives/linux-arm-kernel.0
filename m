From: robh@kernel.org (Rob Herring)
Date: Sat, 17 Nov 2018 10:30:26 -0600
Subject: [PATCH 3/4] dt-bindings: reset: uniphier: Add AHCI core reset
 description
In-Reply-To: <1541727727-10821-4-git-send-email-hayashi.kunihiko@socionext.com>
References: <1541727727-10821-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1541727727-10821-4-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <20181117163026.GA4924@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  9 Nov 2018 10:42:06 +0900, Kunihiko Hayashi wrote:
> Add compatible strings for reset control of AHCI core implemented in
> UniPhier SoCs. The reset control belongs to AHCI glue layer.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  Documentation/devicetree/bindings/reset/uniphier-reset.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
