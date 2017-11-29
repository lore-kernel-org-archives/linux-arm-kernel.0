From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 29 Nov 2017 16:46:49 +0100
Subject: [PATCH] net: stmmac: dwmac-sun8i: fix allwinner,leds-active-low
 handling
In-Reply-To: <CAGb2v67hv7ayH=F-MBG-PCCeVt43PH-O-6b3KOyGXSpr2s4DGg@mail.gmail.com>
References: <20171128164822.29218-1-clabbe.montjoie@gmail.com>
 <20171128173826.GE14512@lunn.ch> <20171129090240.GA3699@Red>
 <20171129153712.GA24881@lunn.ch>
 <CAGb2v67hv7ayH=F-MBG-PCCeVt43PH-O-6b3KOyGXSpr2s4DGg@mail.gmail.com>
Message-ID: <20171129154649.GC24881@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ChenYu
 
> It worked at one point. During some previous iteration, they lit up as
> they were supposed to.

For a released version of the kernel? Or during development work?  If
they did work, but broken, it would be good to know which commit broke
it. We can then add a fixes: tag to the patch as proposed.

    Andrew
