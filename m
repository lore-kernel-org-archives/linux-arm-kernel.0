From: robh@kernel.org (Rob Herring)
Date: Wed, 22 Feb 2017 14:47:46 -0600
Subject: [PATCH 2/7] dt-bindings: rk1108-cru: rename RK1108 to RV1108
In-Reply-To: <1486983857-32399-1-git-send-email-andy.yan@rock-chips.com>
References: <1486983566-32265-1-git-send-email-andy.yan@rock-chips.com>
 <1486983857-32399-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <20170222204746.gcy4j6klz6fidrhq@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2017 at 07:04:17PM +0800, Andy Yan wrote:
> Rockchip finally named the SOC as RV1108, so change it.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---
> 
>  .../{rockchip,rk1108-cru.txt => rockchip,rv1108-cru.txt}     | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>  rename Documentation/devicetree/bindings/clock/{rockchip,rk1108-cru.txt => rockchip,rv1108-cru.txt} (83%)

Acked-by: Rob Herring <robh@kernel.org>
