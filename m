From: robh@kernel.org (Rob Herring)
Date: Tue, 30 Oct 2018 14:30:27 -0500
Subject: [PATCH V8 3/5] dt-bindings: fsl: scu: update power domain binding
In-Reply-To: <1540739690-23750-4-git-send-email-aisheng.dong@nxp.com>
References: <1540739690-23750-1-git-send-email-aisheng.dong@nxp.com>
 <1540739690-23750-4-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20181030193027.GA26215@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 28 Oct 2018 15:19:44 +0000, "A.s. Dong" wrote:
> Update the power domain binding with #power-domain-cells 1 format.
> The first cell can be a global SCU power domain and the 2nd cell
> the device ID. With this approach, we may remove all the sub power
> domain nodes from device tree which can relief the device tree a lot.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-pm at vger.kernel.org
> Cc: devicetree at vger.kernel.org
> Suggested-by: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> ChangeLog:
> v7->v8:
>  * new patch
> ---
>  .../devicetree/bindings/arm/freescale/fsl,scu.txt  | 37 +++++-----------------
>  1 file changed, 8 insertions(+), 29 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
