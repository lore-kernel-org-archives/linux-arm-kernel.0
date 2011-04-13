From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 13 Apr 2011 14:41:49 +0200
Subject: [PATCH 4/6] ARM: mxc: don't allow to compile together i.MX51
	and i.MX53
In-Reply-To: <20110413122503.GB1897@S2100-06.ap.freescale.net>
References: <1302464943-20721-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1302464943-20721-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110413122503.GB1897@S2100-06.ap.freescale.net>
Message-ID: <20110413124149.GR18850@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Wed, Apr 13, 2011 at 08:25:04PM +0800, Shawn Guo wrote:
> On Sun, Apr 10, 2011 at 09:49:01PM +0200, Uwe Kleine-K?nig wrote:
> [...]
> > +	  This enables support for machines using Freescale's i.MX50 and i.MX51
> s/MX51/MX53/
yeah, thanks, as you're not the first one to point this out I already
sent a fixup to Sascha.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
