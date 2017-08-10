From: robh@kernel.org (Rob Herring)
Date: Thu, 10 Aug 2017 11:36:45 -0500
Subject: [PATCH 3/4] dt-bindings: i2c: i2c-davinci: Update binding for
 66AK2Gx pwr dm property
In-Reply-To: <20170802221753.13786-4-fcooper@ti.com>
References: <20170802221753.13786-1-fcooper@ti.com>
 <20170802221753.13786-4-fcooper@ti.com>
Message-ID: <20170810163645.wt52uharpdxhnmbb@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 02, 2017 at 05:17:52PM -0500, Franklin S Cooper Jr wrote:
> Add pm-domains property which is required for 66AK2Gx. Also document 66AK2G
> unique clocks property usage.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-davinci.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
