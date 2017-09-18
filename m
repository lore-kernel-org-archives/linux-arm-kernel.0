From: robh@kernel.org (Rob Herring)
Date: Mon, 18 Sep 2017 14:29:49 -0500
Subject: [PATCH 1/3] dt-bindings: spi: spi-davinci: Update binding for
 66AK2Gx pwr dm property
In-Reply-To: <20170908204638.13149-2-fcooper@ti.com>
References: <20170908204638.13149-1-fcooper@ti.com>
 <20170908204638.13149-2-fcooper@ti.com>
Message-ID: <20170918192949.jm3s2mwvvyadl6y5@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 08, 2017 at 03:46:36PM -0500, Franklin S Cooper Jr wrote:
> Add pm-domains property which is required for 66AK2Gx. Also document 66AK2G
> unique clocks property usage.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-davinci.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
