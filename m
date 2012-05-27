From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 27 May 2012 12:07:36 +0000
Subject: [PATCH RFC] serial/8250: Adjusting FIFO parameters for LPC32xx
In-Reply-To: <4FC21214.7060804@antcom.de>
References: <1338048678-23991-1-git-send-email-stigge@antcom.de>
 <201205271023.16742.arnd@arndb.de> <4FC21214.7060804@antcom.de>
Message-ID: <201205271207.36770.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 27 May 2012, Roland Stigge wrote:
> > Actually some of the other entries are wrong, too. The ns8250 entry should
> > be i8250, and I guess the 16750 and 16850 were also not made by national.
> 
> But maybe we should keep the existing compatible strings because
> existing boards/bootloaders are providing them already?

Right, we should only add to the list. Any entry that's already used potentially
needs to stay in there as you say.

	Arnd
