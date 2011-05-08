From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 8 May 2011 19:19:18 +0200
Subject: [PATCH 13/14] [dove] Remove mpp.[ch]. They are not used.
In-Reply-To: <BANLkTi=mLaj0wa0PA9uokZ5ekuNbSEPthQ@mail.gmail.com>
References: <1304864141-1121-1-git-send-email-andrew@lunn.ch>
	<1304864141-1121-14-git-send-email-andrew@lunn.ch>
	<BANLkTi=mLaj0wa0PA9uokZ5ekuNbSEPthQ@mail.gmail.com>
Message-ID: <20110508171918.GC4071@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 08, 2011 at 05:39:08PM +0300, saeed bishara wrote:
> On Sun, May 8, 2011 at 5:15 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> > ??arch/arm/mach-dove/Makefile | ?? ??2 +-
> > ??arch/arm/mach-dove/mpp.c ?? ??| ??209 ----------------------------------------
> > ??arch/arm/mach-dove/mpp.h ?? ??| ??220 -------------------------------------------
> > ??3 files changed, 1 insertions(+), 430 deletions(-)
> > ??delete mode 100644 arch/arm/mach-dove/mpp.c
> > ??delete mode 100644 arch/arm/mach-dove/mpp.h
> No, it currently not used, by we for sure will use at some point. we
> are planning to prepare such patches for the next release. so please
> keep it.

O.K. I can drop this patch.

I don't have a datasheet for the Dove. Do you think it is possible to
merge the dove mpp setup code with the kirkwood and mv78xx0?

      Thanks
	Andrew
