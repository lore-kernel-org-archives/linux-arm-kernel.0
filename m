From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 16 Apr 2012 09:53:24 +0200
Subject: [GIT PULL] i.MX board feature patches
In-Reply-To: <CAOesGMhakTpuXWnHUnJqiEbzPBeXE1digiyJ+LeoPbjhyFAoLA@mail.gmail.com>
References: <20120411083342.GM3852@pengutronix.de>
 <CAOesGMhakTpuXWnHUnJqiEbzPBeXE1digiyJ+LeoPbjhyFAoLA@mail.gmail.com>
Message-ID: <20120416075324.GP3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 15, 2012 at 11:19:06AM -0700, Olof Johansson wrote:
> Hi,
> 
> On Wed, Apr 11, 2012 at 1:33 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > Hi Arnd, Olof,
> >
> > Please pull the following board feature patches for i.MX
> >
> > Thanks
> > ?Sascha
> >
> > The following changes since commit dd775ae2549217d3ae09363e3edb305d0fa19928:
> >
> > ?Linux 3.4-rc1 (2012-03-31 16:24:09 -0700)
> >
> > are available in the git repository at:
> >
> > ?git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-features-board-20120411
> >
> > for you to fetch changes up to e7259f7ca3a0c7a269fecb61156224ddd3edb92c:
> >
> > ?Visstrim_M10: Add board version detection. (2012-04-11 10:16:03 +0200)
> >
> > ----------------------------------------------------------------
> > misc i.MX board specific features
> >
> > ----------------------------------------------------------------
> > Alex Gershgorin (1):
> > ? ? ?ARM: regulator: i.MX35-PDK Add regulator support
> >
> > Javier Martin (1):
> > ? ? ?Visstrim_M10: Add board version detection.
> 
> 
> Just because I've already have given you the "please keep this in mind
> in the future" comments before, I'm going to ask you to respin this
> branch and fix the patch subjects on the two above patches. The first
> should probably be "ARM: imx: Add regulator support for i.MX35-PDK" or
> so, and the second one needs "ARM: imx:" prefix.
> 
> Branch otherwise looks reasonable, so respin with that fixed and we'll
> pull it in.

Here we go. Hopefully I am aware of this in the future :-/

Sascha

The following changes since commit dd775ae2549217d3ae09363e3edb305d0fa19928:

  Linux 3.4-rc1 (2012-03-31 16:24:09 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-features-board-20120411-2

for you to fetch changes up to 435ca24116bc5365a10fa0be1bf1c1e4c5680157:

  ARM i.MX: Visstrim_M10: Add board version detection. (2012-04-16 09:49:31 +0200)

----------------------------------------------------------------
imx-features-board-20120411

----------------------------------------------------------------
Alex Gershgorin (1):
      ARM: i.MX: i.MX35-PDK: Add regulator support

Javier Martin (1):
      ARM i.MX: Visstrim_M10: Add board version detection.

Uwe Kleine-K?nig (1):
      ARM: imx_v4_v5_defconfig: enable adc and touch driver of mc13783

 arch/arm/configs/imx_v4_v5_defconfig        |    4 +-
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |   55 ++++++++
 arch/arm/mach-imx/mach-mx35_3ds.c           |  193 +++++++++++++++++++++++++++
 3 files changed, 251 insertions(+), 1 deletion(-)

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
