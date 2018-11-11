From: robh@kernel.org (Rob Herring)
Date: Sun, 11 Nov 2018 16:40:20 -0600
Subject: [PATCH V6 4/6] dt-bindings: clock: add imx8qxp lpcg clock binding
In-Reply-To: <1541862894-8209-5-git-send-email-aisheng.dong@nxp.com>
References: <1541862894-8209-1-git-send-email-aisheng.dong@nxp.com>
 <1541862894-8209-5-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20181111224020.GA2539@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 10 Nov 2018 15:20:01 +0000, "A.s. Dong" wrote:
> The Low-Power Clock Gate (LPCG) modules contain a local programming
> model to control the clock gates for the peripherals. An LPCG module
> is used to locally gate the clocks for the associated peripheral.
> 
> Note:
> This level of clock gating is provided after the clocks are generated
> by the SCU resources and clock controls. Thus even if the clock is
> enabled by these control bits, it might still not be running based
> on the base resource.
> 
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  .../devicetree/bindings/clock/imx8qxp-lpcg.txt     |  51 +++++++
>  include/dt-bindings/clock/imx8qxp-clock.h          | 153 +++++++++++++++++++++
>  2 files changed, 204 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/imx8qxp-lpcg.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
