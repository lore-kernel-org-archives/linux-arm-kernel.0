From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 4 Jan 2018 17:20:36 +0100
Subject: [net-next: PATCH 0/8] Armada 7k/8k PP2 ACPI support
In-Reply-To: <20180104160939.GA7785@xora-haswell>
References: <1513588684-15647-1-git-send-email-mw@semihalf.com>
 <CAKv+Gu8_6y3dU81ZS4WWCfpRZkfjGo_+_K--e3go_3_xXwBErQ@mail.gmail.com>
 <20180103110048.GA21230@xora-haswell>
 <CAPv3WKcM8WWvh64A=FTtuWkEr6V_QSKjBpNpWnMpp_P=cMU9sw@mail.gmail.com>
 <20180104160939.GA7785@xora-haswell>
Message-ID: <20180104162036.GL3401@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > I already agreed with 'reg' being awkward in the later emails.
> > Wouldn't _ADR be more appropriate to specify PHY address on MDIO bus?
> > 
> Ah it is an actual address, then yes _ADR is probably more appropriate.

Newbie ACPI question. What is the definition of an address?

In this cause, we are talking about an address of a device on an MDIO
bus. It takes a value between 0 and 31.

How are IC2 device addresses represented in ACPI? MDIO devices and I2C
devices are pretty similar. So it would make sense to use the same as
what I2C uses.

     Andrew
