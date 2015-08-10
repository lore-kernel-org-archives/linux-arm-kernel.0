From: davem@davemloft.net (David Miller)
Date: Mon, 10 Aug 2015 10:57:36 -0700 (PDT)
Subject: [PATCH 0/3] Fixes for the network driver of Marvell Armada 375 SoC
In-Reply-To: <1438880430-5480-1-git-send-email-mw@semihalf.com>
References: <y>
	<1438880430-5480-1-git-send-email-mw@semihalf.com>
Message-ID: <20150810.105736.226528661515254668.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcin Wojtas <mw@semihalf.com>
Date: Thu,  6 Aug 2015 19:00:27 +0200

> This is a set of three patches that fix long-lasting problems implemented in
> the initial support for the Armada 375 network controller.
> 
> Due to an inappropriate concept of handling the per-CPU sent packets'
> processing on TX path the driver numerous problems occured, such as RCU
> stalls. Those have been fixed, of which details you can find in the commit
> logs. The patches were intensively tested on top of v4.2-rc5.
> 
> I'm looking forward to any comments or remarks.

Series applied, thanks.
