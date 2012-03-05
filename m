From: koen@dominion.thruhere.net (Koen Kooi)
Date: Mon, 5 Mar 2012 15:06:19 +0100
Subject: [PATCH] omap3_beagle: Init only uart3 used for console
In-Reply-To: <1330945952-14714-1-git-send-email-govindraj.raja@ti.com>
References: <1330945952-14714-1-git-send-email-govindraj.raja@ti.com>
Message-ID: <12976EFB-912D-44E2-825C-63034F117635@dominion.thruhere.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Op 5 mrt. 2012, om 12:12 heeft Govindraj.R het volgende geschreven:

> From: "Govindraj.R" <govindraj.raja@ti.com>
> 
> On beagle some of uart mux lines are used for other
> purpose so init only uart3.
> 
> Uart2 rx line clashes with gpio_147 used for usb ehci
> phy reset. Initializing uart2 pad_mux lines can break
> ehci module on beagle xm.
> (gpio_147 is available on uart2_rx in mode4 reference 
> mux34xx.c -> uart2_rx.gpio_147)

That's only on xM revision C, right?

regards,

Koen
