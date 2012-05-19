From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 19 May 2012 17:32:32 +0000
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <20120519112431.GH24238@titan.lakedaemon.net>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <alpine.LFD.2.02.1205181846360.11526@xanadu.home>
 <20120519112431.GH24238@titan.lakedaemon.net>
Message-ID: <201205191732.32384.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 19 May 2012, Jason Cooper wrote:
> > Board files in mach-mvebu and the rest in plat-mvebu.  That would match 
> > the spirit of the current split between mach-* and plat-*.
> 
> Took the words right out of my mouth.  Once DT conversions are complete,
> mach-*/ would either go away, or hold legacy non-DT boards.
> 
> On a side note, I also like this because it would make converting old
> board files like sheevaplug and guruplug to DT easier.  The legacy
> implementation would be in mach-mvebu/ and the DT implementation would
> be in plat-mvebu/.  Newcomers to the code would see a clearly defined
> separation.

With that layout, where do the mach/* headers go?

	Arnd
