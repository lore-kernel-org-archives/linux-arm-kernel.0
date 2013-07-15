From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 14 Jul 2013 22:53:45 -0300
Subject: [PATCH 1/1] ARM: imx: clk-pllv3: move the timeout just before the
 comparison
In-Reply-To: <20130715014717.GA23444@nchen-desktop>
References: <1373763528-20792-1-git-send-email-peter.chen@freescale.com>
 <20130714183347.GJ12139@pengutronix.de>
 <20130715014717.GA23444@nchen-desktop>
Message-ID: <CAOMZO5DyXFt8YbJN+Z7pE9z2CZE3G9FaFHrStx6xu-6noTpGPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Sun, Jul 14, 2013 at 10:47 PM, Peter Chen <peter.chen@freescale.com> wrote:

> The root cause of this PLL lock timeout problem is:
>
> http://marc.info/?l=linux-arm-kernel&m=137109340222931&w=2
>
> If causes the jiffies is not precise sometimes. This commit is just an
> improvement.

Your commit log does not explain what it improves, and why/how it
improves things.

Please provide a better description in the commit log.
