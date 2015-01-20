From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 20 Jan 2015 11:54:33 +0100
Subject: [PATCH 8/8] regulator: MT6397: Add support for MT6397 regulator
In-Reply-To: <1421748424.9655.107.camel@x220>
References: <1421747231-554-1-git-send-email-s.hauer@pengutronix.de>
 <1421747231-554-9-git-send-email-s.hauer@pengutronix.de>
 <1421748424.9655.107.camel@x220>
Message-ID: <20150120105433.GF18908@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 11:07:04AM +0100, Paul Bolle wrote:
> On Tue, 2015-01-20 at 10:47 +0100, Sascha Hauer wrote:
> > From: Flora Fu <flora.fu@mediatek.com>
> > 
> > This adds support for the regulators on the MediaTek MT6397
> > Multifunction device.
> > 
> > Signed-off-by: Flora Fu, MediaTek
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Liam Girdwood <lgirdwood@gmail.com>
> > Cc: Mark Brown <broonie@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/mfd/mt6397.txt   |  41 ++-
> 
> This looks new for linux-next ...
> 
> >  .../bindings/regulator/mt6397-regulator.txt        | 217 ++++++++++++++
> 
> but this is already in linux-next. See linux-next commit 269675757901
> ("regulator: Add document for MT6397 regulator"). And ...
> 
> >  drivers/regulator/Kconfig                          |   9 +
> >  drivers/regulator/Makefile                         |   1 +
> >  drivers/regulator/mt6397-regulator.c               | 332 +++++++++++++++++++++
> >  include/linux/regulator/mt6397-regulator.h         |  49 +++
> 
> these are too. See linux-next commit 0425e2420c0a ("egulator: mt6397:
> Add support for MT6397 regulator"). Unless there are difference that
> can't be spotted by looking at the diffstats of those commist, that is.

It seems Mark already merged the regulator part to his tree. Ok, in this
case you can ignore the regulator patch in this series. I think I haven't
made changes to the regulator part in this series.
The other patches are still needed though.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
