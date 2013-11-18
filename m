From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 18 Nov 2013 13:40:22 +0000
Subject: ARM topic: Is DT on ARM the solution,
 or is there something better?
In-Reply-To: <20131118122644.GA26046@ulmo.nvidia.com>
References: <52644A9E.3060007@wwwdotorg.org> <20131118122644.GA26046@ulmo.
 nvidia.com>
Message-ID: <20131118134022.26EE7C409EC@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 Nov 2013 13:26:46 +0100, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Sun, Oct 20, 2013 at 10:26:54PM +0100, Stephen Warren wrote:
> [...]
> > In general, the kernel still needs a complete driver to every last
> > device on every strange board, and needs to support every strange way
> > some random board hooks all the devices together.
> [...]
> 
> This may only be slightly related and it doesn't address all the points
> you brought up here, but for lack of a better place, here goes.
> 
> I've had an interesting discussion with a friend over the weekend which
> eventually turned to a similar topic. With all the recent discussions
> about how to push board-specific details out into firmware, perhaps a
> more drastic measure would be to push for standardization of hardware
> interfaces.

Some hardware does that. That's what OHCI, EHCI, UHCI, XHCI, SDHCI, and
similar are all about. It always helps when well understood hardware
follows a register interface. It doesn't work for everything, but I
agree it would be good to have preferred hw interfaces for SPI & I2C.

g.
