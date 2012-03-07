From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 7 Mar 2012 09:37:36 +0100
Subject: [PATCH v2 17/17] ASoC: fsl: add imx-sgtl5000 machine driver
In-Reply-To: <20120306155055.GA13802@S2101-09.ap.freescale.net>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
 <1330957865-19085-18-git-send-email-shawn.guo@linaro.org>
 <20120305174232.GA3852@pengutronix.de>
 <20120306155055.GA13802@S2101-09.ap.freescale.net>
Message-ID: <20120307083736.GK3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2012 at 11:50:57PM +0800, Shawn Guo wrote:
> On Mon, Mar 05, 2012 at 06:42:32PM +0100, Sascha Hauer wrote:
> > On Mon, Mar 05, 2012 at 10:31:05PM +0800, Shawn Guo wrote:
> > > This is the initial imx-sgtl5000 machine driver support with only
> > > playback dai link implemented.  More features can be added on top
> > > of it later.
> > 
> > Are there problems with capturing? It should be trivial to add and
> > it would be much more confident that this series as a whole works as
> > expected.
> > 
> I worked all day long to try to give that answer.  Here it is.
> 
> No, there is no problem with capturing on fsl_ssi + imx_pcm_dma +
> imx_sgtl5000 side.  But there is a problem with sgtl5000 codec driver.
> With that problem fixed in sgtl5000, this series works just fine with
> capturing.  (I'm not sure I want to fix it within this series though,
> as it's already big enough.)

Thanks a lot for testing this. In this case I'm fine with this series
and can likely Ack your next iteration. You can skip capture support
from this series as you said it's big enough. It's enough for me when
you say it works on your branch.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
