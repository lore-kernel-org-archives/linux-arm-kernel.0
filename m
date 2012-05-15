From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 15 May 2012 18:30:42 +0200
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <4FB2838D.6000507@codethink.co.uk>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120515091838.GC6820@lunn.ch> <4FB22727.6090406@codethink.co.uk>
 <20120515115511.75ece9c3@skate> <4FB269CB.4080804@gmail.com>
 <20120515164438.22258885@skate> <20120515162201.GZ23254@lunn.ch>
 <4FB2838D.6000507@codethink.co.uk>
Message-ID: <20120515163042.GA23254@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >>The 370 and XP both use the PJ4B core
> >
> >Could mach-pj4b be an option?
> 
> Not really, that's the CPU core and will probably get re-used for a
> number of products.

However, if everything is DT based, does that matter? All these
products end up in here.

	 Andrew
