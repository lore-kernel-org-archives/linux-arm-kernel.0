From: robh@kernel.org (Rob Herring)
Date: Tue, 30 Oct 2018 14:30:11 -0500
Subject: [PATCH V8 1/5] dt-bindings: imx: add scu resource id headfile
In-Reply-To: <1540739690-23750-2-git-send-email-aisheng.dong@nxp.com>
References: <1540739690-23750-1-git-send-email-aisheng.dong@nxp.com>
 <1540739690-23750-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20181030193011.GA25741@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 28 Oct 2018 15:19:35 +0000, "A.s. Dong" wrote:
> SCU firmware uses resource id to provide services. Every device on
> a SCU based system has a resource id. Exported it in device tree to
> allow service bindings to use it. e.g. power domain.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> v7->v8:
>  * new patch
> ---
>  include/dt-bindings/firmware/imx/rsrc.h | 559 ++++++++++++++++++++++++++++++++
>  1 file changed, 559 insertions(+)
>  create mode 100644 include/dt-bindings/firmware/imx/rsrc.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
