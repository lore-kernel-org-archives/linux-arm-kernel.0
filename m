From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 6 Feb 2013 08:28:50 -0500
Subject: [PATCH v2 0/4] ARM: mvebu: Add support for SPI flash devices
 in Armada 370/XP
In-Reply-To: <511257C6.2070604@free-electrons.com>
References: <1360155984-15397-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <511257C6.2070604@free-electrons.com>
Message-ID: <20130206132850.GC14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 06, 2013 at 02:16:54PM +0100, Gregory CLEMENT wrote:
> On 02/06/2013 02:06 PM, Ezequiel Garcia wrote:
> > This is second version of the SPI patchset for Armada 370/XP.
> > 
> > This series first adds support for the SPI controller
> > and then adds the SPI flash for the Armada XP GP board.
> > 
> > This series is based on 3.8-rc5 plus:
> >  * "arm: mvebu: support for the new Armada XP development board(DB-MV784MP-GP)"
> >  * "arm: mvebu: i2c come back in defconfig"
> > 
> > Feel free to test or provide any feedback!
> > 
> Ezequiel,
> 
> I reviewed the patches, I have nothing more to say, I can add my:
> 
> Acked-by: Gregory Clement <gregory.clement@free-electrons.com>
> 
> on the patch that didn't have yet.
> 
> Jason,
> could you add this series in your incoming pull request?

That's the plan.  I'm waiting for a response from Olof to see If I need
to redo /boards and /dt.  In either case, my next round of pull requests
with have this and a bunch of other stuff.

thx,

Jason.
