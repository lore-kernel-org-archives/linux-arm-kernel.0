From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 26 Mar 2012 15:25:38 -0300
Subject: [PATCH 4/4] ARM i.MX 3ds debugboard: register a dummy regulator
 for the smsc911x device
In-Reply-To: <20120326181912.GV3852@pengutronix.de>
References: <1330774804-7310-1-git-send-email-s.hauer@pengutronix.de>
 <1330774804-7310-5-git-send-email-s.hauer@pengutronix.de>
 <CAOMZO5DL8YQT2qb=vxdQtdN+zfZLK9H9_1qu5sS+1YAvSo5SAA@mail.gmail.com>
 <20120326181912.GV3852@pengutronix.de>
Message-ID: <CAOMZO5Bw4fFOYSDyiE8o9AnnrzTOukJtA1JFbNBeMMzx-jBVvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 26, 2012 at 3:19 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> At least it did work when I sent the patches, but -EPROBE_DEFER did not
> exist at that time. Do you have the fixed regulator enabled in your
> config?

Yes, I do. I am using imx_v6_v7_defconfig, which has fixed regulator
enabled by default.
