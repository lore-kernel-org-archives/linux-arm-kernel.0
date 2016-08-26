From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 26 Aug 2016 16:33:58 +0200
Subject: [PATCH 0/8] Convert Netgear WNR854T to devicetree
In-Reply-To: <alpine.DEB.2.11.1608261325310.19980@marmot.wormnet.eu>
References: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
 <1472203264-21089-1-git-send-email-jm@lentin.co.uk>
 <op.ymsxegsy2s3iss@ecaz>
 <alpine.DEB.2.11.1608261325310.19980@marmot.wormnet.eu>
Message-ID: <20160826143358.GI25046@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >- the factory layout gives you almost no space to play with

Given that the kernel has grown in size over the years, does the
mainline kernel fit in the factory layout?

> Of course, one could also argue I'm breaking backwards compatibility
> at this point by changing it, so maybe I should put it back.

I don't mind breaking backwards compatibility, if the factory defaults
no longer actually work.....

Also, lets think about the users here. This is a very old box. Anybody
playing with one are probably of the sort who tinker with a classic
car in the garage, taking the engine apart and putting it back
together again. I doubt there are users of this box who take their car
in for a service once they are out of windscreen washing water.

    Andrew
