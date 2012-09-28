From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Sep 2012 20:06:52 +0000
Subject: [PATCH] ARM: Orion5x: ts78xx: Add IOMEM for virtual addresses.
In-Reply-To: <1348841566-18308-1-git-send-email-andrew@lunn.ch>
References: <1348841566-18308-1-git-send-email-andrew@lunn.ch>
Message-ID: <201209282006.52525.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 28 September 2012, Andrew Lunn wrote:
> Also convert logical or to + for register offsets from base
> addresses. This fixes a number of warnings currently seen in
> linux-next:
> 
> warning: passing argument 2 of '__raw_writeb' makes pointer from
> interger without cast.
> 

I had prepared an identical patch but not posted it, so I now
applied your version on top of the iomem cleanup branch that
has all the other changes like this one.

	Arnd
