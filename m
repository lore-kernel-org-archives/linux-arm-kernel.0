From: robh@kernel.org (Rob Herring)
Date: Wed, 30 May 2018 22:17:05 -0500
Subject: [PATCH v3 6/8] dt-bindings: rcar-vin: Add 'hsync-as-de' custom
 prop
In-Reply-To: <1527606359-19261-7-git-send-email-jacopo+renesas@jmondi.org>
References: <1527606359-19261-1-git-send-email-jacopo+renesas@jmondi.org>
 <1527606359-19261-7-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <20180531031704.GA7857@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2018 at 05:05:57PM +0200, Jacopo Mondi wrote:
> Document the boolean custom property 'renesas,hsync-as-de' that indicates
> that the HSYNC signal is internally used as data-enable, when the
> CLKENB signal is not connected.
> 
> As this is a VIN specificity create a custom property specific to the R-Car
> VIN driver.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
> v3:
> - new patch
> ---
>  Documentation/devicetree/bindings/media/rcar_vin.txt | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
