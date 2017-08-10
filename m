From: robh@kernel.org (Rob Herring)
Date: Thu, 10 Aug 2017 15:52:40 -0500
Subject: [PATCH 1/4] pwm: pwm-tiecap: Add TI 66AK2G SoC specific compatible
In-Reply-To: <20170807114943.22612-2-vigneshr@ti.com>
References: <20170807114943.22612-1-vigneshr@ti.com>
 <20170807114943.22612-2-vigneshr@ti.com>
Message-ID: <20170810205240.5inhllnchgp4kqc6@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 07, 2017 at 05:19:40PM +0530, Vignesh R wrote:
> Add a new compatible string "ti,k2g-ecap" to support PWM ECAP IP of
> TI 66AK2G SoC.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-tiecap.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
