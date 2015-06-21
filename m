From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 21 Jun 2015 22:11:23 +0200
Subject: [RFC PATCH] ARM: dts: Convert Linkstation Mini to Device Tree
In-Reply-To: <1434909415.5657.33.camel@dolka.fr>
References: <1434765234.5177.25.camel@dolka.fr>
 <20150620173421.GJ2936@io.lakedaemon.net>
 <1434909415.5657.33.camel@dolka.fr>
Message-ID: <20150621201123.GC12665@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > We're trying to move the dts{i} files to dual license.  Please take a
> > look at the current armada-*.dts{i} license blocks.  If you are ok with
> > it, please change the above to match.
> 
> OK, so this is moving to dual-licensed GPLv2+ and X11? I am OK with it,
> if Alexey and Thomas are too (Thomas, your Armada changes are dual
> -licensed while your orion5x and GPLv2 only; is this because of the
> previous work licences?).

I can put this onto my TODO list. Of the existing files, the
orion5x.dtsi should probably be done first, since that is used by all
boards.

	Andrew
