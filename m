From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 15 Dec 2017 14:03:22 +0100
Subject: [PATCH 20/25] arm: kirkwood: dts: Remove leading 0x and 0s from
 bindings notation
In-Reply-To: <20171215124653.30902-1-malat@debian.org>
References: <20171215124653.30902-1-malat@debian.org>
Message-ID: <20171215130322.GG4213@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Warning (unit_address_format): Node /XXX unit name should not have leading "0x"
> 
> and
> 
> Warning (unit_address_format): Node /XXX unit name should not have leading 0s

Humm, it actually looks like the compiler is broken. None of the lines
you are changing in this, or the orion5x file, have 0x or leading 0.

       Andrew
