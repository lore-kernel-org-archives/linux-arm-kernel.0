From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 19 Jan 2017 10:02:34 -0200
Subject: [PATCH 3/4] ARM: dts: imx7d-cl-som: Fix OTG power pinctrl
In-Reply-To: <20170119090924.19636-4-s.hauer@pengutronix.de>
References: <20170119090924.19636-1-s.hauer@pengutronix.de>
 <20170119090924.19636-4-s.hauer@pengutronix.de>
Message-ID: <CAOMZO5Dwb5oQS5K-C45z5W9TtLzUAreVXcjWAiXMbV+b39GVMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 7:09 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> GPIO01_IO05 is controlled by the LPSR iomux controller, so attach
> the corresponding pin to this controller.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
