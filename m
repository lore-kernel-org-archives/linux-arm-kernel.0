From: robh@kernel.org (Rob Herring)
Date: Tue, 31 Jul 2018 13:09:11 -0600
Subject: [PATCH v8 2/4] dt-bindings: mailbox: imx-mu: add generic MU
 channel support
In-Reply-To: <20180731141146.10788-3-o.rempel@pengutronix.de>
References: <20180731141146.10788-1-o.rempel@pengutronix.de>
 <20180731141146.10788-3-o.rempel@pengutronix.de>
Message-ID: <20180731190911.GA23014@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 04:11:44PM +0200, Oleksij Rempel wrote:
> Each MU has four pairs of rx/tx data register with four rx/tx interrupts
> which can also be used as a separate channel.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/mailbox/fsl,mu.txt    | 28 +++++++++++++++++--
>  1 file changed, 25 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
