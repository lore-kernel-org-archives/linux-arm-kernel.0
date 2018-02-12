From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 12 Feb 2018 21:35:18 +0800
Subject: [PATCH v2 1/4] dt-bindings: add binding for i.MX8MQ CCM
In-Reply-To: <20180201175412.9480-1-l.stach@pengutronix.de>
References: <20180201175412.9480-1-l.stach@pengutronix.de>
Message-ID: <20180212133438.GB2939@X250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 01, 2018 at 06:54:09PM +0100, Lucas Stach wrote:
> This adds the binding for the i.MX8MQ Clock Controller Module.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Reviewed-by: Rob Herring <robh@kernel.org>

Hi Stephen,

To make your life a bit easier, I plan to collect drivers/clk/imx/
patches and send you pull request at a proper time.  Doing this will
also help resolve the clock ID dependency between clock driver and
device trees.  Sounds good to you?

Shawn
