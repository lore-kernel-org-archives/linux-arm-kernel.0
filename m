From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 18 Feb 2015 19:16:39 -0200
Subject: [PATCH 4/7] serial: imx: drop support for IRDA
In-Reply-To: <1424292068-28197-4-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1424292068-28197-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1424292068-28197-4-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CAOMZO5AfE_tikox7d49=9ZtSD8R0_mGuuOQWZEg+E3rTqL4LSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Wed, Feb 18, 2015 at 6:41 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> Support for IRDA was added in 2009 in commit v2.6.31-rc1~399^2~2. There
> are no in-tree users.

'fsl,irda-mode' is still documented at
Documentation/devicetree/bindings/serial/fsl-imx-uart.txt .

Is the irda support broken?

Maybe there are people using it in out-of-tree dts files?
