From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 15 May 2012 12:03:20 +0200
Subject: [PATCH 2/8] arm: mach-armada: add source files
In-Reply-To: <4FB225DC.6090805@codethink.co.uk>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1337072084-21967-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <4FB225DC.6090805@codethink.co.uk>
Message-ID: <20120515100320.GF6820@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >+		timer at d0020300 {
> >+			       compatible = "marvell,timer";
> 
> Is this really a generic marvell timer block?

Looking at the code below, its very similar to plat-orion timer.

I've not look at all the details, but i suspect it should not have its own timer
implementation, it should just be using plat-orion functions.

	Andrew
