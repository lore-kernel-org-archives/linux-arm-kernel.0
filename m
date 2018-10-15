From: robh@kernel.org (Rob Herring)
Date: Mon, 15 Oct 2018 14:12:51 -0500
Subject: [PATCH 1/2] dt-bindings: pwm: tiecap: Add TI AM654 SoC specific
 compatible
In-Reply-To: <20181003170658.3835-2-vigneshr@ti.com>
References: <20181003170658.3835-1-vigneshr@ti.com>
 <20181003170658.3835-2-vigneshr@ti.com>
Message-ID: <20181015191251.GA8949@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 3 Oct 2018 22:36:57 +0530, Vignesh R wrote:
> Add a new compatible string "ti,am654-ecap" to support PWM ECAP IP of
> TI AM654 SoC.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-tiecap.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
