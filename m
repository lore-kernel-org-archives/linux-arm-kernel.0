From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 29 Jul 2014 04:24:46 +0200
Subject: CPU1 fails to boot on Armada 375 DB with 3.16.0-rc6
In-Reply-To: <53D7035F.40803@opengear.com>
References: <53D6F564.5070803@opengear.com> <20140729015352.GC12303@lunn.ch>
 <53D7035F.40803@opengear.com>
Message-ID: <20140729022446.GD12303@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The Rev 2 dev board comes with 2G of RAM.

Hi Ken

Bit of a long short, but try changing the amount of memory in the DTS
file.

	Andrew
