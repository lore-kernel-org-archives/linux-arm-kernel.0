From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 30 Jan 2012 22:02:59 +0800
Subject: [PATCH v7] ARM/mx35/3ds: gpio: add mc9s08dz60 gpio function
In-Reply-To: <20120130120823.GH705@game.jcrosoft.org>
References: <1327905080-23623-1-git-send-email-b39297@freescale.com>
 <20120130120823.GH705@game.jcrosoft.org>
Message-ID: <20120130140256.GA11568@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2012 at 01:08:23PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 14:31 Mon 30 Jan     , Wu Guoxing wrote:
> > From: wu guoxing <b39297@freescale.com>
> > 
> > we only use the gpio function of mc9s08dz60 mcu chip, so just
> > add the gpio driver, as this mcu will never be used in other board.
> > 
> > Signed-off-by: Wu Guoxing <b39297@freescale.com>
> > Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> please add the of bindings directly
> 
We do not have device tree support on imx3 yet, so I'm not sure we can
test it. 

-- 
Regards,
Shawn
