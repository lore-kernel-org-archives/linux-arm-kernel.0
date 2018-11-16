From: robh@kernel.org (Rob Herring)
Date: Fri, 16 Nov 2018 17:07:33 -0600
Subject: [PATCH v5 07/12] dt-bindings: clock: mediatek: delete mmsys clocks
In-Reply-To: <20181116125449.23581-8-matthias.bgg@kernel.org>
References: <20181116125449.23581-1-matthias.bgg@kernel.org>
 <20181116125449.23581-8-matthias.bgg@kernel.org>
Message-ID: <20181116230733.GA17794@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Nov 2018 13:54:44 +0100, matthias.bgg at kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> Some SoCs will now load the clock part of mmsys via
> a platform device from the dsiplay driver.
> Remove the compatible from the clock bindings description.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---
>  .../devicetree/bindings/arm/mediatek/mediatek,mmsys.txt        | 3 ---
>  1 file changed, 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
