From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 3 Jan 2018 13:47:20 +0100
Subject: [net-next: PATCH 0/8] Armada 7k/8k PP2 ACPI support
In-Reply-To: <CAPv3WKcM8WWvh64A=FTtuWkEr6V_QSKjBpNpWnMpp_P=cMU9sw@mail.gmail.com>
References: <1513588684-15647-1-git-send-email-mw@semihalf.com>
 <CAKv+Gu8_6y3dU81ZS4WWCfpRZkfjGo_+_K--e3go_3_xXwBErQ@mail.gmail.com>
 <20180103110048.GA21230@xora-haswell>
 <CAPv3WKcM8WWvh64A=FTtuWkEr6V_QSKjBpNpWnMpp_P=cMU9sw@mail.gmail.com>
Message-ID: <20180103124720.GG15036@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I already agreed with 'reg' being awkward in the later emails.
> Wouldn't _ADR be more appropriate to specify PHY address on MDIO bus?

Also, how do you specify which MDIO bus the PHY is on. To fully
specify a PHY, you need both bits of information.

In DT, the phy-handle phandle can point to any PHY anywhere in the
system. This is particularly important when a Ethernet device has two
MDIO busses.

     Andrew
