From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 30 Jan 2012 13:08:23 +0100
Subject: [PATCH v7] ARM/mx35/3ds: gpio: add mc9s08dz60 gpio function
In-Reply-To: <1327905080-23623-1-git-send-email-b39297@freescale.com>
References: <1327905080-23623-1-git-send-email-b39297@freescale.com>
Message-ID: <20120130120823.GH705@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:31 Mon 30 Jan     , Wu Guoxing wrote:
> From: wu guoxing <b39297@freescale.com>
> 
> we only use the gpio function of mc9s08dz60 mcu chip, so just
> add the gpio driver, as this mcu will never be used in other board.
> 
> Signed-off-by: Wu Guoxing <b39297@freescale.com>
> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
please add the of bindings directly

Best Regards,
J.
