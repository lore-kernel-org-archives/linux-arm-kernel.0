From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 May 2012 17:09:36 +0000
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <20120522160316.GY24238@titan.lakedaemon.net>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <alpine.LFD.2.02.1205221023050.13185@xanadu.home>
 <20120522160316.GY24238@titan.lakedaemon.net>
Message-ID: <201205221709.36898.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 May 2012, Jason Cooper wrote:
> On Tue, May 22, 2012 at 10:25:28AM -0400, Nicolas Pitre wrote:
> > On Mon, 21 May 2012, Arnd Bergmann wrote:
> > 
> > I'd suggest that mach-mvebu be created earlier for the new EBU ARmada 
> > SOC support though.
> 
> I'd like to second that, and suggest moving mach-kirkwood/board-*.c to
> it.  Basically, make it the one location for marvell SoC dt boards.

Yes, that was what I meant when I said we move everything but the *-setup.c
files.

	Arnd
