From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 16 Feb 2013 12:44:36 -0500
Subject: [PATCH v2 4/4] ARM: mvebu: Update defconfig to select SPI
 flash and MTD support
In-Reply-To: <20130216173445.GA3440@localhost>
References: <1360155984-15397-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1360155984-15397-5-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130216150228.GR14746@titan.lakedaemon.net>
 <20130216173445.GA3440@localhost>
Message-ID: <20130216174436.GC23237@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 16, 2013 at 02:34:47PM -0300, Ezequiel Garcia wrote:
> Hi Jason,
> 
> On Sat, Feb 16, 2013 at 10:02:28AM -0500, Jason Cooper wrote:
> > On Wed, Feb 06, 2013 at 10:06:24AM -0300, Ezequiel Garcia wrote:
> > > The Armada XP DB-MV784MP-GP board has an SPI flash device.
> > > These options allow to access that device over MTD.
> > > 
> > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > > ---
> > > Depends on patch: "arm: mvebu: i2c come back in defconfig"
> > > 
> > >  arch/arm/configs/mvebu_defconfig |    3 +++
> > >  1 files changed, 3 insertions(+), 0 deletions(-)
> > 
> > Applied to mvebu/boards
> > 
> 
> Great!
> 
> Are we still in time for a pull request for v3.9
> with all of these stuff?

With any amount of luck, possibly ;-)

Jason.
