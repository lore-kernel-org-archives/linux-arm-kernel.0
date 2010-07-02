From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 2 Jul 2010 10:33:10 +0100
Subject: [PATCH 29/33] Removing dead SND_SOC_SMDK2443_WM9710
In-Reply-To: <AANLkTim0usB99K6orH0lxP73e-XK69ytdECtR5D1dPJt@mail.gmail.com>
References: <cover.1277911345.git.siccegge@cs.fau.de>
	<e5391de6858597bbfd43874aed124a73f74850b5.1277911346.git.siccegge@cs.fau.de>
	<AANLkTinZa7_TEjYFTu9V6obndpVvMmHppaOArM1AJg_t@mail.gmail.com>
	<20100701130724.GC17698@sirena.org.uk>
	<AANLkTim0usB99K6orH0lxP73e-XK69ytdECtR5D1dPJt@mail.gmail.com>
Message-ID: <20100702093310.GA19712@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 02, 2010 at 04:08:56PM +0900, Jassi Brar wrote:
> On Thu, Jul 1, 2010 at 10:07 PM, Mark Brown

> > Hrm, if this is part of the default hardware build we should get the
> > driver merged.

> But the machine driver is already there
>    sound/soc/s3c24xx/smdk2443_wm9710.c

Oh, right.  I was just assuming that it wasn't there since the symbol
isn't defined in mainline, I hadn't actually looked.
