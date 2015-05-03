From: baruch@tkos.co.il (Baruch Siach)
Date: Sun, 3 May 2015 10:55:49 +0300
Subject: [PATCH 2/4] mtd: mxc_nand: limit the size of used oob
In-Reply-To: <CAOMZO5AAcRu3gscLSQTiRExeS_pXO-uJm0uA3fL5uwYUUMMsqQ@mail.gmail.com>
References: <20150426200725.GC19431@pengutronix.de>
 <20150427043906.GR2258@tarshish>
 <20150427071238.GE19431@pengutronix.de>
 <20150427072057.GT2258@tarshish>
 <20150427075023.GF19431@pengutronix.de>
 <20150427114341.GW2258@tarshish>
 <20150427193127.GU19431@pengutronix.de>
 <20150429061853.GB2258@tarshish>
 <20150429063508.GE19431@pengutronix.de>
 <CAOMZO5AAcRu3gscLSQTiRExeS_pXO-uJm0uA3fL5uwYUUMMsqQ@mail.gmail.com>
Message-ID: <20150503075549.GH2265@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Thu, Apr 30, 2015 at 12:20:32PM -0300, Fabio Estevam wrote:
> On Wed, Apr 29, 2015 at 3:35 AM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> 
> > That's surprising. It would be interesting to hear from Freescale what
> > is wrong here (Fabio? Maybe contact support?). I quickly skimmed through
> > the errata documents but didn't found anything. So it's not only that
> 
> Yes, that's something I am not aware of either.
> 
> Please contact the FSL support folks so that the hardware guys could
> assist on this topic.

Our past experience with hardware support at the micro level was not all that 
great. Anyway, I dropped the limit to 128 for oobsize < 218, since this is 
only a theoretic bug, and I can't really test it.

Thanks,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
