From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 4 Nov 2017 21:17:21 +0100
Subject: [PATCH 07/12] hwrng: bcm2835-rng: Manage an optional clock
In-Reply-To: <20171104200806.GS9463@n2100.armlinux.org.uk>
References: <20171102010408.27736-1-f.fainelli@gmail.com>
 <20171102010408.27736-8-f.fainelli@gmail.com>
 <944505791.223880.1509803454887@email.1und1.de>
 <e12063f9-86e4-e9ce-2a7f-f85fe2ce352f@gmail.com>
 <547786283.132202.1509819754396@email.1und1.de>
 <20171104193731.GA751@lunn.ch>
 <20171104200806.GS9463@n2100.armlinux.org.uk>
Message-ID: <20171104201721.GA1394@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The clk API outside of DT doesn't have knowledge of when it's "complete"
> to be able to determine whether the clock is not present or temporarily
> missing.  I've already NAK'd this suggestion.

Hi Russell

O.K, yes, makes sense.

We do have of_clk_get_by_name() and of_clk_get(). Would optional
variants of these be acceptable?

	 Andrew
