From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 9 Jan 2013 09:54:23 +0100
Subject: [PATCH 1/5] ARM: Kirkwood: Convert NS2 to gpio-poweroff.
In-Reply-To: <20130109084112.GQ1357@kw.sim.vm.gnt>
References: <1356704050-5047-1-git-send-email-andrew@lunn.ch>
 <20130109084112.GQ1357@kw.sim.vm.gnt>
Message-ID: <20130109085423.GG3392@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 09, 2013 at 09:41:13AM +0100, Simon Guinot wrote:
> On Fri, Dec 28, 2012 at 03:14:10PM +0100, Andrew Lunn wrote:
> > Remove C code and add a Device Tree node in its place.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> > 
> > This is untested. I've been known to get the active hi/low the wrong
> > way around so that the board powers off as the driver loads at boot
> > time. So it would be very good to have a tested-by: sign off.
> > 
> > 
> >  arch/arm/boot/dts/kirkwood-ns2-common.dtsi |    6 ++++++
> >  arch/arm/mach-kirkwood/board-ns2.c         |   14 --------------
> >  2 files changed, 6 insertions(+), 14 deletions(-)
> 
> Tested-by: Simon Guinot <simon.guinot@sequanux.org>
> 
> Andrew, do you want me to rebase your patch on the top of the pinctrl
> conversion one ?

Hi Simon

Thanks for testing.

What will probably be best is to wait until the next -rc comes out
containing the pinctrl fixes and then rebase on top of that.

Thanks
	Andrew
