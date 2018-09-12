From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 12 Sep 2018 08:23:35 +0200
Subject: [PATCH] ARM: dts: imx53-qsb: disable 1.2GHz OPP
In-Reply-To: <20180912012252.GE28469@dragon>
References: <20180910125056.30813-1-s.hauer@pengutronix.de>
 <20180912012252.GE28469@dragon>
Message-ID: <20180912062335.GB7949@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Wed, Sep 12, 2018 at 09:22:54AM +0800, Shawn Guo wrote:
> On Mon, Sep 10, 2018 at 02:50:56PM +0200, Sascha Hauer wrote:
> > The maximum CPU frequency for the i.MX53 QSB is 1GHz, so disable the
> > 1.2GHz OPP. This makes the board work with cpufreq again.
> 
> I feel that the word 'again' and the Fixes tag below are a little
> confusing.  It makes impression that cpufreq worked fine on the board
> before and commit 791f416608 broke it.  However, this is not the case,
> right?

You're right, the "again" shouldn't be there. I meant that the board
works "again" after the addition of cpufreq support broke it.

Just resent the patch with a rephrased commit message.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
