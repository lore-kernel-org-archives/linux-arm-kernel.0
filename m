From: robh@kernel.org (Rob Herring)
Date: Thu, 1 Mar 2018 15:51:42 -0600
Subject: [PATCH v2 15/19] dt-bindings: gpio: Add support for r8a77965
In-Reply-To: <1519139541-18783-16-git-send-email-jacopo+renesas@jmondi.org>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519139541-18783-16-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <20180301215142.fr3s5ycsuoq7jvbb@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 20, 2018 at 04:12:17PM +0100, Jacopo Mondi wrote:
> Add compatible string for R-Car M3-N (r8a77965) in gpio-rcar.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> ---
> v1 -> v2:
> - Drop SoC-specific compatible string from drivers/gpio/gpio-rcar.c
> - Change patch subject to reflect it only changes dt bindings
> ---
>  Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
