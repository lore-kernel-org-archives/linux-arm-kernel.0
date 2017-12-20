From: robh@kernel.org (Rob Herring)
Date: Wed, 20 Dec 2017 15:24:25 -0600
Subject: [PATCH v2 2/9] dt-bindings: arm: brcmstb: Correct BIUCTRL node
 documentation
In-Reply-To: <20171219192247.29799-3-f.fainelli@gmail.com>
References: <20171219192247.29799-1-f.fainelli@gmail.com>
 <20171219192247.29799-3-f.fainelli@gmail.com>
Message-ID: <20171220212425.4y6u5i7xhrcfek6k@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 11:22:40AM -0800, Florian Fainelli wrote:
> Correct the Device Tree bindings for the HIF_CPUBIUCTRL node whose
> compatible string is actually brcm,bcm<chip-id>-cpu-biu-ctrl. Also
> document in the binding the fallback property
> ("brcm,brcmstb-cpu-biu-ctrl") and update the example accordingly.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../devicetree/bindings/arm/bcm/brcm,brcmstb.txt   | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
