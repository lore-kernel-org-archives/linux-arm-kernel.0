From: robh@kernel.org (Rob Herring)
Date: Thu, 9 Aug 2018 15:37:55 -0600
Subject: [PATCH v3 1/4] dt-bindings: add binding for i.MX8MQ CCM
In-Reply-To: <1533825941-17224-2-git-send-email-abel.vesa@nxp.com>
References: <1533825941-17224-1-git-send-email-abel.vesa@nxp.com>
 <1533825941-17224-2-git-send-email-abel.vesa@nxp.com>
Message-ID: <20180809213755.GA23245@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 09, 2018 at 05:45:38PM +0300, Abel Vesa wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> This adds the binding for the i.MX8MQ Clock Controller Module.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  .../devicetree/bindings/clock/imx8mq-clock.txt     |  20 +
>  include/dt-bindings/clock/imx8mq-clock.h           | 629 +++++++++++++++++++++
>  2 files changed, 649 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/imx8mq-clock.txt
>  create mode 100644 include/dt-bindings/clock/imx8mq-clock.h

Please add acks/reviewed-bys when posting new versions even if it was 
back in January.

Rob
