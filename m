From: broonie@sirena.org.uk (Mark Brown)
Date: Mon, 28 Dec 2009 19:22:44 +0000
Subject: Ethernet in a cold climate / SMDK6410
In-Reply-To: <4B3901E3.20004@warmcat.com>
References: <4B38FB80.9050609@warmcat.com>
	<20091228190009.GB14799@sirena.org.uk> <4B3901E3.20004@warmcat.com>
Message-ID: <20091228192244.GD14799@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 28, 2009 at 07:07:15PM +0000, Andy Green wrote:

> So what was your setup when Ethernet worked OK...

>  - the Samsung U-Boot fork that came with the SMDK?

Yes, whatever was flashed on it when Samsung last had the board.  The
bootloader does explicitly say it's looking for the SMSC chip when
setting it up.

>  - magic address 0x18000000 OK

Yes.

>  - 60+ minidip config was what?

Factory default - I can't immediately visualise which switches you're
talking about and I'm out of the office until next Monday so I can't
check with the boards how they're set up.  I don't recall any relevant
switches.

> I'm guessing 0x18000000 is on a particular nCS signal that needs
> configuring (should that really not be the business of the machine
> definition file?) and the mini DIPs setting to match.

I'd expect so.  

I'm not sure what you mean by the "machine definition file" here?  The
large number of non-probable and incompatible changes on the Samsung
boards mean that it's generally best to leave them at factory default
settings unless you have a particular need to change things since the
kernel tends to be configured for the default setup.
