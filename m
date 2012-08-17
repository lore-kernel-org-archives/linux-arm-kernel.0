From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 17 Aug 2012 20:35:49 -0300
Subject: [alsa-devel] Lockups reading from i.MX51 SSI registers
In-Reply-To: <20120817222738.GH18871@opensource.wolfsonmicro.com>
References: <20120810195005.GP24328@opensource.wolfsonmicro.com>
 <20120810195638.GF1451@pengutronix.de>
 <20120810201456.GL25520@pengutronix.de>
 <20120810210647.GG1451@pengutronix.de>
 <CAOMZO5DAs=jm-08tWdfdLG_nm=gdi-Q_RReiUKGM_RCgB82dwA@mail.gmail.com>
 <20120817222738.GH18871@opensource.wolfsonmicro.com>
Message-ID: <CAOMZO5BgeW_z-zf3Auw6RCJg1o5L=DqWdVeF+0Xb_W=6hZJMnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 17, 2012 at 7:27 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Aug 17, 2012 at 04:08:47PM -0300, Fabio Estevam wrote:
>
>> Also, for the playback to work you need to install the SDMA firmware.
>
> This is deadlocking during boot, I'm getting nowhere near trying
> playback.

Are you running a dt or non-dt kernel? In case of a dt kernel, can you
share the dts file?
