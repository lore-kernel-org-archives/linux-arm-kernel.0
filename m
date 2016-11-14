From: robh@kernel.org (Rob Herring)
Date: Mon, 14 Nov 2016 11:28:26 -0600
Subject: [PATCH v4 3/3] dt-bindings: i2c: pxa: Update the documentation
 for the Armada 3700
In-Reply-To: <20161109115715.2557-4-romain.perier@free-electrons.com>
References: <20161109115715.2557-1-romain.perier@free-electrons.com>
 <20161109115715.2557-4-romain.perier@free-electrons.com>
Message-ID: <20161114172826.75mctimsbh4snk4w@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 09, 2016 at 12:57:15PM +0100, Romain Perier wrote:
> This commit documents the compatible string to have the compatibility for
> the I2C unit found in the Armada 3700.
> 
> Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
> ---
> 
> Changes in v2:
>  - Fixed wrong compatible string, it should be "marvell,armada-3700-i2c"
>    and not "marvell,armada-3700".
> 
>  Documentation/devicetree/bindings/i2c/i2c-pxa.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
