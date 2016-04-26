From: davem@davemloft.net (David Miller)
Date: Tue, 26 Apr 2016 12:26:24 -0400 (EDT)
Subject: [PATCH 1/6] bus: Add shared MDIO bus framework
In-Reply-To: <20160426121335.GC11668@lunn.ch>
References: <20160425205650.GA31129@lunn.ch>
 <666dffb41a922b0c8638f2f002a2de08@mail.gmail.com>
 <20160426121335.GC11668@lunn.ch>
Message-ID: <20160426.122624.967268334782802268.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Lunn <andrew@lunn.ch>
Date: Tue, 26 Apr 2016 14:13:35 +0200

> On Tue, Apr 26, 2016 at 02:03:27PM +0530, Pramod Kumar wrote:
>> As you can see from above points, trying to re-use Linux Ethernet MDIO mux
>> framework for non-Ethernet PHYs is not the right way.
> 
> And as i pointed out, all your arguments are wrong, bar one. And i
> doubt that one argument is sufficient to duplicate a lot of code which
> already exists and does 95% of what you need.

+1
