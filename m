From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 17 Aug 2012 16:08:47 -0300
Subject: [alsa-devel] Lockups reading from i.MX51 SSI registers
In-Reply-To: <20120810210647.GG1451@pengutronix.de>
References: <20120810195005.GP24328@opensource.wolfsonmicro.com>
 <20120810195638.GF1451@pengutronix.de>
 <20120810201456.GL25520@pengutronix.de>
 <20120810210647.GG1451@pengutronix.de>
Message-ID: <CAOMZO5DAs=jm-08tWdfdLG_nm=gdi-Q_RReiUKGM_RCgB82dwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 10, 2012 at 6:06 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> One clock is for the bus which must be turned on. The other is for the
> bitclock which we currently can ignore since we only support clock slave
> mode.
> On an i.MX5 ssi[123]_ipg_gate must be turned on by the ssi driver. From
> a quick look to the clock code it looks correct.

I tested audio playback on a mx51evk board last week using linux-next
and it worked fine (it has a sgtl5000).

I don't have any hardware with ac97 to try it.

Also, for the playback to work you need to install the SDMA firmware.

Regards,

Fabio Estevam
