From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 22 Feb 2016 08:21:30 +0100
Subject: [PATCH] dma: mv_xor_v2: new driver
In-Reply-To: <20160222025349.GC15973@rob-hp-laptop>
References: <1455523083-25506-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160222025349.GC15973@rob-hp-laptop>
Message-ID: <20160222082130.75e9c540@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

On Sun, 21 Feb 2016 20:53:49 -0600, Rob Herring wrote:

> > +Required properties:
> > +- compatible: Should be "marvell,mv-xor-v2"
> 
> and an SoC specific compatible please.

So you mean *both* marvell,mv-xor-v2 and a SoC specific compatible?

> "marvell,mv" is a bit redundant.

True. I guess marvell,xor-v2 will do.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
