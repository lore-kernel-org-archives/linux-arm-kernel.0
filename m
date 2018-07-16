From: robh@kernel.org (Rob Herring)
Date: Mon, 16 Jul 2018 09:55:39 -0600
Subject: [PATCH v3 5/9] dt-bindings: ata: ahci-platform: fix indentation
 of target-supply
In-Reply-To: <1531479786-4911-6-git-send-email-clabbe@baylibre.com>
References: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
 <1531479786-4911-6-git-send-email-clabbe@baylibre.com>
Message-ID: <20180716155539.GA5354@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2018 at 11:03:02AM +0000, Corentin Labbe wrote:
> This patch fix the indentation of target-supply's ':'.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  Documentation/devicetree/bindings/ata/ahci-platform.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This one should come before the others. Fixes/restructuring before 
features.

Acked-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> index a5281d7557e3..47652521a6ed 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> @@ -50,7 +50,7 @@ Sub-nodes required properties:
>  - reg		    : the port number
>  And at least one of the following properties:
>  - phys		    : reference to the SATA PHY node
> -- target-supply    : regulator for SATA target power
> +- target-supply     : regulator for SATA target power
>  
>  Examples:
>          sata at ffe08000 {
> -- 
> 2.16.4
> 
