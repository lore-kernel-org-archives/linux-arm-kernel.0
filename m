From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 23 Sep 2013 11:10:36 +0200
Subject: [PATCH 11/26] ARM: dove: remove custom .init_time hook
In-Reply-To: <523EE08C.60309@gmail.com>
References: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1379526839-14798-12-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130921122226.GB31180@lunn.ch> <523EE08C.60309@gmail.com>
Message-ID: <20130923091036.GE4999@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 22, 2013 at 02:20:28PM +0200, Sebastian Hesselbarth wrote:
> On 09/21/2013 02:22 PM, Andrew Lunn wrote:
> >On Wed, Sep 18, 2013 at 07:53:44PM +0200, Sebastian Hesselbarth wrote:
> >>With arch/arm calling of_clk_init(NULL) from time_init(), we can now
> >>remove custom .init_time hooks. While at it, also remove some obsolete
> >>includes.
> >>
> >>Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> >>---
> >>Cc: Olof Johansson <olof@lixom.net>
> >>Cc: Arnd Bergmann <arnd@arndb.de>
> >>Cc: Jason Cooper <jason@lakedaemon.net>
> >>Cc: Andrew Lunn <andrew@lunn.ch>
> >>Cc: Russell King <linux@arm.linux.org.uk>
> >>Cc: linux-arm-kernel at lists.infradead.org
> >>Cc: linux-kernel at vger.kernel.org
> >>---
> >>  arch/arm/mach-dove/board-dt.c |   11 -----------
> >>  1 file changed, 11 deletions(-)
> [...]
> >Boot tested on cubox.
> >
> >Tested-by: Andrew Lunn <andrew@lunn.ch>
> 
> Thanks Andrew!
> 
> Aren't you giving any Acks for dove/kirkwood anymore?

Hi Sebastian

In my opinion, a Tested-by: has more weight than an Acked-by. I could
of given you an Acked-by in about 60 seconds, given the simplicity of
the patch. It took a lot more effort to get your tree, build it, fix
my binutils, since it was the first 3.12 tree i had tried and my
binutils was too old, and boot it.

	 Andrew
