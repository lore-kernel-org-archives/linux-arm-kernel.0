From: ore@pengutronix.de (Oleksij Rempel)
Date: Wed, 31 May 2017 16:55:36 +0200
Subject: [PATCH v2 4/6] regulator: pfuze100: add fsl,pmic_stby_poweroff
 property
In-Reply-To: <20170531144438.xwdbrmb76ortbgnx@sirena.org.uk>
References: <20170531061457.23744-1-o.rempel@pengutronix.de>
 <20170531061457.23744-5-o.rempel@pengutronix.de>
 <20170531144438.xwdbrmb76ortbgnx@sirena.org.uk>
Message-ID: <20170531145536.r2hoeoohc7eiyhw4@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 31, 2017 at 03:44:38PM +0100, Mark Brown wrote:
> On Wed, May 31, 2017 at 08:14:55AM +0200, Oleksij Rempel wrote:
> > Document the new optional "fsl,pmic_stby_poweroff" property.
> 
> I'm missing both the cover letter and the rest of the series, what's
> going on with dependencies here?

Hmm... I probably needed to add same list of maintainers to all patches.
I will fix it next time. The patches are here:
https://patchwork.kernel.org/bundle/olerem/poweroff/

Should I resend it with complete Cc list?

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
