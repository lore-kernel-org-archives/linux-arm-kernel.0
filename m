From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 5 Mar 2012 18:42:32 +0100
Subject: [PATCH v2 17/17] ASoC: fsl: add imx-sgtl5000 machine driver
In-Reply-To: <1330957865-19085-18-git-send-email-shawn.guo@linaro.org>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
 <1330957865-19085-18-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120305174232.GA3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2012 at 10:31:05PM +0800, Shawn Guo wrote:
> This is the initial imx-sgtl5000 machine driver support with only
> playback dai link implemented.  More features can be added on top
> of it later.

Are there problems with capturing? It should be trivial to add and
it would be much more confident that this series as a whole works as
expected.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
