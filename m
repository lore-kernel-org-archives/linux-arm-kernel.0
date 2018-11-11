From: robh@kernel.org (Rob Herring)
Date: Sun, 11 Nov 2018 16:38:13 -0600
Subject: [PATCH V6 2/6] dt-bindings: clock: imx8qxp: add SCU clock IDs
In-Reply-To: <1541862894-8209-3-git-send-email-aisheng.dong@nxp.com>
References: <1541862894-8209-1-git-send-email-aisheng.dong@nxp.com>
 <1541862894-8209-3-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20181111223813.GA31512@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 10 Nov 2018 15:19:53 +0000, "A.s. Dong" wrote:
> Add IMX8QXP SCU clock IDs.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: devicetree at vger.kernel.org
> Cc: linux-clk at vger.kernel.org
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> v6: new patch, separate from driver changes to avoid a checkpatch warning
>     IDs are changed a lot due to SCU divider/gate/mux are merged into
>     one general SCU clock and LPCG clocks are moved out.
> ---
>  include/dt-bindings/clock/imx8qxp-clock.h | 136 ++++++++++++++++++++++++++++++
>  1 file changed, 136 insertions(+)
>  create mode 100644 include/dt-bindings/clock/imx8qxp-clock.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
