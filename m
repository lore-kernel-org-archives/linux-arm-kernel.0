From: robh@kernel.org (Rob Herring)
Date: Mon, 16 Jul 2018 09:16:54 -0600
Subject: [PATCH v3 1/3] dt-bindings: arm: fsl: add mu binding doc
In-Reply-To: <20180716114209.25242-2-o.rempel@pengutronix.de>
References: <20180716114209.25242-1-o.rempel@pengutronix.de>
 <20180716114209.25242-2-o.rempel@pengutronix.de>
Message-ID: <20180716151654.GA21819@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2018 at 01:42:07PM +0200, Oleksij Rempel wrote:
> The Messaging Unit module enables two processors within
> the SoC to communicate and coordinate by passing messages
> (e.g. data, status and control) through the MU interface.

v3? I already gave my R-by on v4 from Dong. Please coordinate your work 
on this.

> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/mailbox/fsl,mu.txt    | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/fsl,mu.txt
