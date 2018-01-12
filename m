From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 12 Jan 2018 14:55:26 +0100
Subject: PM regression in next
In-Reply-To: <20180112135203.GA4821@atomide.com>
References: <20180112000037.GA3875@atomide.com>
 <20180112013257.GB4059@atomide.com>
 <4913146.sVL6sFxzC8@aspire.rjw.lan>
 <4745593.FguGN2uIkX@aspire.rjw.lan>
 <e7a673e1-b28d-f84e-c6c1-c5b896e92aeb@metafoo.de>
 <20180112131623.GA29734@lunn.ch>
 <20180112135203.GA4821@atomide.com>
Message-ID: <20180112135526.GC29734@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Thanks that fixes the suspend error. And I was able to confirm
> that the suspend power consumption is OK.
> 
> That still leaves the mystery of the runtime idle power consumption
> being much higher with commit e130bc1d00a4.

Did you re-measure the runtime power? Do you have an unused PHY? It
could be it is not getting shut down. 1G PHYs can be quite power
hungry.

	Andrew
