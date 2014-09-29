From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 29 Sep 2014 12:58:42 +0200
Subject: [PATCHv4 0/4] pwm: imx: support output polarity inversion
In-Reply-To: <20140826092409.7dea5530@ipc1.ka-ro>
References: <1408517756-9412-1-git-send-email-LW@KARO-electronics.de>
 <20140826092409.7dea5530@ipc1.ka-ro>
Message-ID: <20140929105842.GG4958@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 09:24:09AM +0200, Lothar Wa?mann wrote:
> Hi,
> 
> Lothar Wa?mann wrote:
> > This patch series adds support for polarity inversion to the pwm-imx
> > driver. The patches have been tested on i.MX6, i.MX53 and with the
> > ti-ehrpwm.c driver.
> > 
> > Changes wrt. v2:
> > - make the use of '#pwm-cells = <3>' optional, so that the change does
> >   not break existing DT blobs as suggested by Arnd Bergmann and Sascha
> >   Hauer.
> > 
> > Changes wrt. v3:
> > - implemented the approach suggested by Sascha Hauer 
> > - don't modify struct pwm_ops in the imx_pwm probe function
> > 
> > 
> Any further comments?

No, except this one:

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
