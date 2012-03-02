From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 2 Mar 2012 23:36:29 +0100
Subject: [PATCH 4/4] ARM: kirkwood: convert orion-wdt to fdt.
In-Reply-To: <20120302170252.GJ11986@titan.lakedaemon.net>
References: <cover.1330625877.git.jason@lakedaemon.net>
 <201203021456.47896.arnd@arndb.de>
 <20120302153614.GG11986@titan.lakedaemon.net>
 <201203021648.52523.arnd@arndb.de>
 <20120302170252.GJ11986@titan.lakedaemon.net>
Message-ID: <20120302223629.GA21080@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Andrew Lunn said that he has a patch for plat-orion to use the generic
> > clock framework. I think we should look at that before introducing
> > a hack that will have to be removed again very soon.
> 
> I asked him for it earlier [1], apparently it's a very invasive patch
> series which breaks things.  I would like to look at it as a reference,
> even if applying it isn't a good idea.

I did not say it breaks things. I said i have a habit of breaking
orion5x, because i cannot test it.

I will send the patches as RFC on Sunday. I'm traveling at the moment.

  Andrew
