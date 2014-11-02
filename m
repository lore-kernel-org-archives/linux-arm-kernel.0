From: olof@lixom.net (Olof Johansson)
Date: Sun, 2 Nov 2014 13:41:11 -0800
Subject: [PATCH 4/4] ARM: config: Add DLINK DIR665 options to
 multi_v5_defconfig
In-Reply-To: <20141101234220.GN3698@titan.lakedaemon.net>
References: <1414793613-11798-1-git-send-email-andrew@lunn.ch>
 <1414793613-11798-5-git-send-email-andrew@lunn.ch>
 <20141101234220.GN3698@titan.lakedaemon.net>
Message-ID: <20141102214111.GB17643@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 01, 2014 at 07:42:20PM -0400, Jason Cooper wrote:
> arm-soc folks,
> 
> On Fri, Oct 31, 2014 at 11:13:33PM +0100, Andrew Lunn wrote:
> > Enable building of the switch chip driver and the wireless driver
> > needed by the DLINK DIR665
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > Cc: arm at kernel.org
> > ---
> >  arch/arm/configs/multi_v5_defconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> I went ahead and picked this since I don't foresee too many conflicts
> like there are with multi_v7_defconfig.  Please let me know if you would
> prefer to take changes to this file directly.

Depends on if there's much other v5 activity this cycle or not. I don't think
there is a whole lot so you should be safe.


-Olof
