From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 7 Feb 2014 10:02:48 +0100
Subject: [PATCH 03/21] ARM: Kirkwood: Convert mv88f6281gtw_ge switch
 setup to DT
In-Reply-To: <20140207092505.4a0e9963@skate>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-4-git-send-email-andrew@lunn.ch>
 <20140207092505.4a0e9963@skate>
Message-ID: <20140207090248.GA17758@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 09:25:05AM +0100, Thomas Petazzoni wrote:
> Dear Andrew Lunn,
> 
> On Fri,  7 Feb 2014 00:41:59 +0100, Andrew Lunn wrote:
> > The mv88f6281gtw_ge has a ethernet switch connected to the ethernet
> > port of the SoC. Convert the platform device instantiationn to a DT
> > instantiation.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  arch/arm/mach-kirkwood/Kconfig                 |  7 ----
> >  arch/arm/mach-kirkwood/Makefile                |  1 -
> >  arch/arm/mach-kirkwood/Module.symvers          |  0
> >  arch/arm/mach-kirkwood/board-dt.c              |  3 --
> >  arch/arm/mach-kirkwood/board-mv88f6281gtw_ge.c | 50 --------------------------
> >  arch/arm/mach-kirkwood/common.h                |  7 ----
> >  6 files changed, 68 deletions(-)
> >  create mode 100644 arch/arm/mach-kirkwood/Module.symvers
> 
> This is probably a mistake.
> 
> >  delete mode 100644 arch/arm/mach-kirkwood/board-mv88f6281gtw_ge.c
> 
> Hum, I maybe missed something, but where are the corresponding DT
> informations added to replace the C description of the Ethernet switch?

Hi Thomas

Yes, i screwed that patch up somewhere.

It will be fixed in v2.

   Andrew
