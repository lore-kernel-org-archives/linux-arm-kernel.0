From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Feb 2014 20:16:23 +0100
Subject: [PATCH v8.1 1/6] dt-bindings: sram: describe option to reserve
 parts of the memory
In-Reply-To: <2574291.evU61mFTUd@phil>
References: <21117503.1c6iOkvYSr@phil> <201402251419.31151.arnd@arndb.de>
 <2574291.evU61mFTUd@phil>
Message-ID: <201402272016.23521.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 February 2014, Heiko St?bner wrote:
> Some SoCs need parts of their sram for special purposes. So while being part
> of the peripheral, it should not be part of the genpool controlling the sram.
> 
> Therefore add the option to define reserved regions as subnodes of the
> sram-node similar to defining reserved global memory regions.
> 
> Originally
> Suggested-by: Rob Herring <robherring2@gmail.com>
> 
> Using subnodes for reserved regions
> Suggested-by: Grant Likely <grant.likely@linaro.org>
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Ulrich Prinz <ulrich.prinz@googlemail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
