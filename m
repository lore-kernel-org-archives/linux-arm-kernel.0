From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 24 May 2013 18:53:15 +0200
Subject: [PATCH 2/2] net: mv643xx_eth: proper initialization for Kirkwood
 SoCs
In-Reply-To: <20130524164636.GV31290@titan.lakedaemon.net>
References: <1369253042-15082-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369253042-15082-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130522201607.GA18823@obsidianresearch.com>
 <20130523160111.GP31290@titan.lakedaemon.net>
 <20130523171112.GB31281@obsidianresearch.com>
 <20130523172339.GQ31290@titan.lakedaemon.net>
 <20130523175357.GB2821@obsidianresearch.com>
 <20130523184028.GU31290@titan.lakedaemon.net>
 <20130523190140.GA4010@obsidianresearch.com>
 <20130524164636.GV31290@titan.lakedaemon.net>
Message-ID: <20130524165315.GX26249@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Why are you not keen on this? It seems like normal device driver
> > practice, that is what the data field of of_device_id is typically
> > used for..
> 
> I'm not keen on it because we don't have a document saying "All kirkwood
> SoCs need PSC1 set to X after reset."  We know it, but have we tested
> the 6282?

6282 looses its MAC address, that much i know. I've no idea about
PSC1, but if its MAC address behaviour is the same as 6281, is expect
PSC1 is the same.

	Andrew
