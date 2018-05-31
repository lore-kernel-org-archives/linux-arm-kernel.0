From: robh@kernel.org (Rob Herring)
Date: Wed, 30 May 2018 22:17:43 -0500
Subject: [PATCH v3 8/8] ARM: dts: rcar-gen2: Remove unused VIN properties
In-Reply-To: <1527606359-19261-9-git-send-email-jacopo+renesas@jmondi.org>
References: <1527606359-19261-1-git-send-email-jacopo+renesas@jmondi.org>
 <1527606359-19261-9-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <20180531031743.GA8607@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2018 at 05:05:59PM +0200, Jacopo Mondi wrote:
> The 'bus-width' and 'pclk-sample' properties are not parsed by the VIN
> driver and only confuse users. Remove them in all Gen2 SoC that use
> them.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
> v3:
> - remove bus-width from dt-bindings example
> ---
>  Documentation/devicetree/bindings/media/rcar_vin.txt | 1 -
>  arch/arm/boot/dts/r8a7790-lager.dts                  | 3 ---
>  arch/arm/boot/dts/r8a7791-koelsch.dts                | 3 ---
>  arch/arm/boot/dts/r8a7791-porter.dts                 | 1 -
>  arch/arm/boot/dts/r8a7793-gose.dts                   | 3 ---
>  arch/arm/boot/dts/r8a7794-alt.dts                    | 1 -
>  arch/arm/boot/dts/r8a7794-silk.dts                   | 1 -
>  7 files changed, 13 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
