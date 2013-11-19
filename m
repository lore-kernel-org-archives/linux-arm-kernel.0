From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 19 Nov 2013 15:30:15 +0100
Subject: [PATCH v4 0/4] Add support for the Allwinner A31 Reset Controllers
In-Reply-To: <20131119074929.GE5325@lukather>
References: <1384539547-29463-1-git-send-email-maxime.ripard@free-electrons.com>
 <1384798284.4348.33.camel@pizza.hi.pengutronix.de>
 <20131119074929.GE5325@lukather>
Message-ID: <1384871415.6790.30.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Am Dienstag, den 19.11.2013, 08:49 +0100 schrieb Maxime Ripard:
> Hi Philipp,
> 
> On Mon, Nov 18, 2013 at 07:11:24PM +0100, Philipp Zabel wrote:
> > Hi Maxime,
> > 
> > Am Freitag, den 15.11.2013, 19:19 +0100 schrieb Maxime Ripard:
> > > Hi everyone,
> > > 
> > > This patchset adds support for the reset controllers found in the Allwinner A31
> > > SoCs. Since these controllers are pretty simple, basically just a few MMIO
> > > registers, with a single bit controlling the reset state of the other devices
> > > it asserts in reset, the driver is quite simple as well.
> > > 
> > > However, one of the IPs asserted in reset by these controllers are the timers,
> > > the only thing standing out is that it requires to be registered before the
> > > timers are initialized.
> > > 
> > > Thanks,
> > > Maxime
> > 
> > Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> Thanks.
> 
> Do you want to merge this through your tree?

since 0d74578b7de73c4b7f25daaacff8d5091fa83bd4 "ARM: sunxi:
remove .init_time hooks", patch 3/4 doesn't apply against soc/for-next
anymore.
I could take the first patch now, and you merge the other three through
your tree afterwards?

regards
Philipp
