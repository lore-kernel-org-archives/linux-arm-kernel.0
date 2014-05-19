From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 May 2014 11:12:05 +0200
Subject: [PATCH RFC 00/11] Remove mach-kirkwood
In-Reply-To: <20140516095953.19522ebd@free-electrons.com>
References: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
 <8332148.Z1shujgC24@wuerfel> <20140516095953.19522ebd@free-electrons.com>
Message-ID: <4484941.ZWPK5p5yoC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 May 2014 09:59:53 Thomas Petazzoni wrote:
> Dear Arnd Bergmann,
> 
> On Thu, 15 May 2014 16:36:35 +0200, Arnd Bergmann wrote:
> 
> > There are three other series that may or may not make it into 3.16
> > and that will have conflicts with this one:
> > 
> > - remove mv78xx0
> > - remove mach-dove
> > - convert orion5x to multiplatform
> 
> The work on Orion5x is still on-going. I'd like to progressively
> continue the DT migration of Orion5x, moving to multiplatform, and then
> once it's done, move into mach-mvebu. I'd appreciate to not rush things
> more than necessary.

Yes, that's fine. I'd just want to be sure we all understand what is
going into 3.16 and what isn't.

So your plan for now is to do DT support in 3.16 and multiplatform after
3.16? That won't have any conflicts with the kirkwood patches then, as
far as I can tell.

What about dove? Are we ready to remove it or do we give it another
cycle?

	Arnd
