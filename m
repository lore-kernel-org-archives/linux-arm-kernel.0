From: davem@davemloft.net (David Miller)
Date: Fri, 26 May 2017 15:02:42 -0400 (EDT)
Subject: [PATCH 0/2] Document and use eeprom-length property
In-Reply-To: <1495755884-31341-1-git-send-email-andrew@lunn.ch>
References: <1495755884-31341-1-git-send-email-andrew@lunn.ch>
Message-ID: <20170526.150242.515745885812232154.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Lunn <andrew@lunn.ch>
Date: Fri, 26 May 2017 01:44:42 +0200

> The mv88e6xxx switch driver allows the size of the attached EEPROM to
> be described in DT. This property is missing from the binding
> documentation. Add it. And make use of it on the ZII Devel B board.
> 
> David, Shawn, please could you talk amongs yourself to decide who
> takes what.

I can take this if it works for Shawn, otherwise I'm also fine if Shawn
takes it and if so feel free to add my:

Acked-by: David S. Miller <davem@davemloft.net>
