From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 30 Mar 2011 09:36:51 +0200
Subject: [PATCH v2 1/1] ARM: imx: add gpu device
In-Reply-To: <1301465128-401-1-git-send-email-richard.zhao@freescale.com>
References: <1301465128-401-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <20110330073651.GR7285@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2011 at 02:05:28PM +0800, Richard Zhao wrote:
> From: Richard Zhao <richard.zhao@linaro.org>
> 
> Add mxc_gpu devices for imx35/50/51/53, so external gpu driver module built
> for the kernel can work.

Why do we need this? I have never seen a driver for this.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
