From: horms@verge.net.au (Simon Horman)
Date: Fri, 16 Sep 2016 11:50:45 +0200
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Updates for
 v4.9
In-Reply-To: <14474684.Hhngk1emgJ@wuerfel>
References: <cover.1473234371.git.horms+renesas@verge.net.au>
 <14474684.Hhngk1emgJ@wuerfel>
Message-ID: <20160916095045.GE14562@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 13, 2016 at 05:35:25PM +0200, Arnd Bergmann wrote:
> On Wednesday, September 7, 2016 9:49:30 AM CEST Simon Horman wrote:
> > Second Round of Renesas ARM Based SoC DT Updates for v4.9
> > 
> > Fixes (for v4.9):
> > * Correct PWM clock parent on r8a7794 SoC
> > 
> > Clean-up:
> > * Remove obsolete vsp1 properties from r8a779[01] SoCs
> > 
> > New boards:
> > * Add r8a7792/wheat and r7s72100/rskrza1 boards
> > 
> > Enablement:
> > * Enable LEDs, DU, SDHI on r8a7792/blanche board
> > * Enable MMCIF and SDHI on r8a7794/alt board
> > * Add SPI and VSP1 to r8a7792 SoC
> > * Add ethernet to r7s72100 SoC
> > 
> 
> Pulled into next/dt, thanks!

Great, thanks for handling this and the other pull requests I sent last week.
