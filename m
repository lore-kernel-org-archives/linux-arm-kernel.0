From: robh@kernel.org (Rob Herring)
Date: Tue, 24 Jul 2018 17:19:09 -0600
Subject: [PATCH v6 3/5] dt-bindings: mailbox: imx-mu: add generic MU
 channel support
In-Reply-To: <20180722063923.30222-4-o.rempel@pengutronix.de>
References: <20180722063923.30222-1-o.rempel@pengutronix.de>
 <20180722063923.30222-4-o.rempel@pengutronix.de>
Message-ID: <20180724231909.GA13980@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 22, 2018 at 08:39:21AM +0200, Oleksij Rempel wrote:
> Each MU has four pairs of rx/tx data register with four rx/tx interrupts
> which can also be used as a separate channel.
> 
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/mailbox/fsl,mu.txt | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
